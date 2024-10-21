<script>
  import { createEventDispatcher } from "svelte";
  const dispatch = createEventDispatcher();
  let username = "";
  let firstName = "";
  let lastName = "";
  let password = "";
  let email = "";
  let dob = "";
  let blurb = "";
  let usernameAvailable = null;
  let checkingUsername = false;
  let confirmPassword = "";
  let passwordsMatch = true;

  let selectedAvatar = "";
  let avatarOptions = [
    { name: "Avatar 1", src: "/avatars/avatar1.png" },
    { name: "Avatar 2", src: "/avatars/avatar2.png" },
    { name: "Avatar 3", src: "/avatars/avatar3.png" },
    { name: "Avatar 4", src: "/avatars/avatar4.png" },
    { name: "Avatar 5", src: "/avatars/avatar5.png" },
  ];
  function checkPasswords() {
    passwordsMatch = password === confirmPassword;
  }
 async function checkUsername() {
    if (username.length === 0) {
      usernameAvailable = null;
      return;
    }

    checkingUsername = true;

    try {
      const response = await fetch(
        `http://localhost:3000/api/users/check-username?username=${username}`
      );
      const data = await response.json();

      usernameAvailable = data.available; // `data.available` should be true or false
    } catch (error) {
      console.error("Error checking username:", error);
      usernameAvailable = null; // Reset if there's an error
    } finally {
      checkingUsername = false;
    }
  }

  function handleSubmit() {
    dispatch("submit", { selectedAvatar, username, firstName, lastName, password,email,dob, blurb });
    console.log("Submitting user data:", selectedAvatar);
  }
</script>

<form on:submit|preventDefault={handleSubmit}>
  <label for="avatar">Choose an Avatar:</label>
  <div class="avatar-selection">
    {#each avatarOptions as avatar}
      <button
        class="avatar-option"
        class:avatar-selected={selectedAvatar === avatar.src}
        on:click={() => (selectedAvatar = avatar.src)}
      >
        <img src={avatar.src} alt={avatar.name} />
      </button>
    {/each}
  </div>
  {#if selectedAvatar}
    <p>
      Your Avatar: <img
        src={selectedAvatar}
        alt="Selected Avatar"
        class="avatar-selected-display"
      />
    </p>
  {/if}
  <label for="username">username:</label>
  <input type="text" bind:value={username} name="username" on:blur={checkUsername} required />
  {#if usernameAvailable === true}
    <span style="color: green;">Username is available!</span>
  {/if}
  {#if usernameAvailable === false}
    <span style="color: red;">Username is already taken.</span><br />
  {/if}
  <label for="firstName">First name:</label>
  <input type="text" bind:value={firstName} name="firstName" required />
  <label for="lastName">Last name:</label>
  <input type="text" bind:value={lastName} name="lastName" required />
  <label for="password">password:</label>
  <input type="password" bind:value={password} name="password" required />
  <label for="confirmPassword">Re-enter password:</label>
  <input
    type="password"
    bind:value={confirmPassword}
    name="confirmPassword"
    required
    on:blur={checkPasswords}
  />
  {#if !passwordsMatch && confirmPassword.length > 0}
    <p style="color: red;">Passwords do not match.</p>
  {/if}
  <label for="email">Email:</label>
  <input type="email" bind:value={email} name="email" required />
  <label for="dob">Date of Birth:</label>
  <input type="date" bind:value={dob} name="dob" required />
  <label for="blurb">Blurb:</label>
  <textarea bind:value={blurb} rows="12" required />
  <button type="submit" disabled={!usernameAvailable || !passwordsMatch}>Submit</button>
</form>

<style>
  form {
    max-width: 400px; /* Set form width */
    margin: 0 auto;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    background-color: #f9f9f9;
  }

  label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
  }
  input,
  textarea {
    width: 100%; /* Full width for inputs */
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
    font-size: 14px;
    margin-top: 5px;
  }

  textarea {
    resize: none;
  }

  button {
    width: 100%;
    background-color: #ad9fdd;
    color: white;
    padding: 10px;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
  }

  button:hover {
    background-color: #45a049;
  }

  img {
    width: 50px;
    height: 50px;
    border-radius: 50%;
  }
  .avatar-option {
    border: 2px solid transparent;
    padding: 5px;
    cursor: pointer;
    background: none; /* Remove default button background */
    border: none; /* Remove default button border */
  }
  .avatar-selected {
    border: 2px solid green; /* Highlight selected avatar with a green border */
  }
  .avatar-option {
    width: fit-content;
  }
  .avatar-selection {
    display: flex;
    flex-direction: row;
    gap: 10px;
  }
</style>
