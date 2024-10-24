<script>
  import { createEventDispatcher } from "svelte";
  const dispatch = createEventDispatcher();
  import { PUBLIC_IMAGES_URL,PUBLIC_API_BASE_URL } from "$env/static/public";

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
    { name: "Avatar 1", src: "avatars/avatar1.png" },
    { name: "Avatar 2", src: "avatars/avatar2.png" },
    { name: "Avatar 3", src: "avatars/avatar3.png" },
    { name: "Avatar 4", src: "avatars/avatar4.png" },
    { name: "Avatar 5", src: "avatars/avatar5.png" },
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
        `${PUBLIC_API_BASE_URL}/users/check-username?username=${username}`
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
  <label for="avatar">Choose an Avatar<span style="color: red">*</span>:</label>
  <div class="avatar-selection">
    {#each avatarOptions as avatar}
      <button type="button"
        class="avatar-option"
        class:avatar-selected={selectedAvatar === avatar.src}
        on:click={() => (selectedAvatar = avatar.src)}
      >
        <img src={`${PUBLIC_IMAGES_URL}/${avatar.src}`} alt={avatar.name} />
      </button>
    {/each}
  </div>
  {#if selectedAvatar}
    <p>
      Your Avatar: <img
        src={`${PUBLIC_IMAGES_URL}/${selectedAvatar}`}
        alt="Selected Avatar"
        class="avatar-selected-display"
      />
    </p>
  {/if}
  <label for="username">username<span style="color: red">*</span>:</label>
  <input type="text" bind:value={username} name="username" on:blur={checkUsername} placeholder="Enter your username"required />
  {#if usernameAvailable === true}
    <span style="color: green;">Username is available!</span>
  {/if}
  {#if usernameAvailable === false}
    <span style="color: red;">Username is already taken.</span><br />
  {/if}
  <label for="firstName">First name<span style="color: red">*</span>:</label>
  <input type="text" bind:value={firstName} name="firstName" placeholder="Enter your first name" required />
  <label for="lastName">Last name<span style="color: red">*</span>:</label>
  <input type="text" bind:value={lastName} name="lastName" placeholder="Enter your last name" required />
  <label for="password">password<span style="color: red">*</span>:</label>
  <input type="password" bind:value={password} name="password" placeholder="Password must be at least 6 characters long" required />
  <label for="confirmPassword">Re-enter password<span style="color: red">*</span>:</label>
  <input
    type="password"
    bind:value={confirmPassword}
    name="confirmPassword" placeholder="Re-enter your password"
    required
    on:blur={checkPasswords}
  />
  {#if !passwordsMatch && confirmPassword.length > 0}
    <p style="color: red;">Passwords do not match.</p>
  {/if}
  <label for="email">Email<span style="color: red">*</span>:</label>
  <input type="email" bind:value={email} name="email" placeholder="Enter your email" required />
  <label for="dob">Date of Birth<span style="color: red">*</span>:</label>
  <input type="date" bind:value={dob} name="dob" required />
  <label for="blurb">Blurb:</label>
  <textarea bind:value={blurb} rows="12" placeholder="Tell us a bit about yourself" />
  <button type="submit" disabled={!usernameAvailable || !passwordsMatch}>Submit</button>
</form>

<style>
 form {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  }

  label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
    color: #333;
  }

  input[type="text"],
  input[type="password"],
  input[type="email"],
  input[type="date"],
  textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
    box-sizing: border-box;
  }

  input[type="text"]:focus,
  input[type="password"]:focus,
  input[type="email"]:focus,
  input[type="date"]:focus,
  textarea:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
  }

  .avatar-selection {
    display: flex;
    flex-wrap: wrap;
    margin-bottom: 20px;
  }

  .avatar-option {
    border: 2px solid transparent;
    padding: 5px;
    border-radius: 50%;
    margin-right: 10px;
    cursor: pointer;
    background-color: transparent;
  }

  .avatar-option img {
    width: 50px;
    height: 50px;
    border-radius: 50%;
  }

  .avatar-selected {
    border-color: #007bff;
  }

  .avatar-selected-display {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    margin-left: 10px;
    vertical-align: middle;
  }

  button[type="submit"] {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  button[type="submit"]:disabled {
    background-color: #ccc;
  }

  span {
    font-size: 14px;
  }

  p {
    font-size: 16px;
    margin-bottom: 20px;
  }

  
  span,p {
    font-size: 14px;
    margin: 0;
  }

  
  @media (max-width: 768px) {
    form {
      padding: 15px;
    }

    .avatar-option img {
      width: 40px;
      height: 40px;
    }

    .avatar-selected-display {
      width: 40px;
      height: 40px;
    }
  }
</style>
