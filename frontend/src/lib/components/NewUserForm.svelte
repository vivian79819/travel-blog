<script>
  import { createEventDispatcher } from "svelte";
  const dispatch = createEventDispatcher();
  import { PUBLIC_IMAGES_URL, PUBLIC_API_BASE_URL } from "$env/static/public";

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
  let passwordError = "";
  let selectedAvatar = "";
  let avatarOptions = [];

  // Fetch avatars from backend
  const fetchAvatars = async () => {
    try {
      const response = await fetch(`${PUBLIC_API_BASE_URL}/avatars`);
      avatarOptions = await response.json();
    } catch (error) {
      console.error("Failed to fetch avatars:", error);
    }
  };

  // Fetch avatars when the component is mounted
  fetchAvatars();
  function checkLength() {
    if (password.length > 0 && password.length < 6) {
      passwordError = "Password must be at least 6 characters long.";
    } else {
      passwordError = ""; 
    }
  }
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
    dispatch("submit", {
      selectedAvatar,
      username,
      firstName,
      lastName,
      password,
      email,
      dob,
      blurb
    });
    console.log("Submitting user data:", selectedAvatar);
  }
</script>

<form on:submit|preventDefault={handleSubmit}>
  <label for="avatar">Choose an Avatar<span style="color: red">*</span>:</label>
  <div class="avatar-selection">
    {#each avatarOptions as avatar}
      <button
        type="button"
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
  <label for="username">Username<span style="color: red">*</span>:</label>
  <input
    type="text"
    bind:value={username}
    name="username"
    on:blur={checkUsername}
    placeholder="Enter your username"
    required
  />
  {#if usernameAvailable === true}
    <span style="color: green;">Username is available!</span>
  {/if}
  {#if usernameAvailable === false}
    <span style="color: red;">Username is already taken.</span><br />
  {/if}
  <label for="firstName">First Name<span style="color: red">*</span>:</label>
  <input
    type="text"
    bind:value={firstName}
    name="firstName"
    placeholder="Enter your first name"
    required
  />
  <label for="lastName">Last Name<span style="color: red">*</span>:</label>
  <input
    type="text"
    bind:value={lastName}
    name="lastName"
    placeholder="Enter your last name"
    required
  />
  <label for="password">Password<span style="color: red">*</span>:</label>
  <input
    type="password"
    bind:value={password}
    name="password"
    placeholder="Password must be at least 6 characters long"
    required
    on:blur={checkLength}
  />
  {#if passwordError}
    <p style="color: red;">{passwordError}</p>
    <!-- Display the error message if it exists -->
  {/if}

  <label for="confirmPassword">Re-enter Password<span style="color: red">*</span>:</label>
  <input
    type="password"
    bind:value={confirmPassword}
    name="confirmPassword"
    placeholder="Re-enter your password"
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
    padding: 2rem;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    border: none;
    box-sizing: border-box;
  }

  label {
    display: block;
    margin-bottom: 0.5rem;
    color: black;
    font-weight: 500;
    font-size: 0.875rem;
  }

  input[type="text"],
  input[type="password"],
  input[type="email"],
  input[type="date"],
  textarea {
    width: 100%;
    padding: 0.75rem 1rem;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    background-color: white;
    font-size: 0.875rem;
    margin-bottom: 1.5rem;
    box-sizing: border-box;
  }

  input::placeholder {
    color: var(--orange);
  }

  .avatar-selection {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin-bottom: 1.5rem;
  }

  .avatar-option {
    border: 2px solid transparent;
    padding: 2px;
    border-radius: 50%;
    
    background-color: transparent;
  }

  .avatar-option img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
  }

  .avatar-selected {
    border-color: var(--orange);
  }

  button[type="submit"] {
    width: 100%;
    padding: 0.75rem 1.5rem;
    background-color: var(--orange);
    color: white;
    border: none;
    border-radius: 6px;
    font-weight: 500;
    font-size: 1rem;
    
    transition: background-color 0.15s ease;
    margin-top: 0.5rem;

    &:hover {
      background-color: var(--nuetral);
      color: var(--orange);
      border: 1px solid var(--orange);
    }
  }

  button[type="submit"]:disabled {
    background-color: #cbd5e1;
    cursor: not-allowed;
  }

  span[style*="color: red"] {
    color: #ef4444;
    margin-left: 0.25rem;
  }
</style>
