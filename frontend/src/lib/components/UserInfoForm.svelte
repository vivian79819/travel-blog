<script>
  import { invalidateAll, invalidate } from "$app/navigation";
  import { USER_URL } from "$lib/js/api-urls.js";
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import { goto } from "$app/navigation";
  import { AUTH_URL } from "$lib/js/api-urls.js";

  export let user;

  let selectedAvatar = user.selectedAvatar;
  let username = user.username;
  let firstName = user.firstName;
  let lastName = user.lastName;
  let email = user.email;
  let dob = user.dob;
  let blurb = user.blurb;
  let error = false;
  let success = false;

  let showAvatarSelector = false;
  let avatarOptions = [
    { name: "Avatar 1", src: "/avatars/avatar1.png" },
    { name: "Avatar 2", src: "/avatars/avatar2.png" },
    { name: "Avatar 3", src: "/avatars/avatar3.png" },
    { name: "Avatar 4", src: "/avatars/avatar4.png" },
    { name: "Avatar 5", src: "/avatars/avatar5.png" }
  ];

  async function handleSave() {
    console.log('Selected Avatar:', selectedAvatar);
    error = false;
    success = false;

    const response = await fetch(USER_URL, {
      method: "PATCH",
      credentials: "include",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        selectedAvatar,
        username,
        firstName,
        lastName,
        email,
        dob,
        blurb
      })
    });

    success = response.status === 204;
    error = !success;

    if (success) invalidate(USER_URL);
  }
  async function handleDeleteUser(e) {
    const response = await fetch(`${PUBLIC_API_BASE_URL}/users/${user.id}`, {
      method: "DELETE"
    });

    if (response.status === 204) {
      // Invalidating this URL will cause our +page.js load() function to rerun, because that load() function
      // depends on this URL.

      alert(`Deleted!`);
      const deleteToken = await fetch(AUTH_URL, {
        method: "DELETE",
        credentials: "include"
      });
      await invalidateAll();
      goto("/");
    } else {
      alert(`Unexpected status code received: ${response.status}`);
    }
  }

  function toggleAvatarSelection() {
    showAvatarSelector = !showAvatarSelector;
  }
</script>

<form on:submit|preventDefault={handleSave}>
  <p>
    Your Avatar: <button type="button" on:click={() => toggleAvatarSelection()}
      ><img src={selectedAvatar} alt="Selected Avatar" /></button
    >
  </p>
  {#if showAvatarSelector}
    <label for="avatar">Choose an avatar:</label>
    <div class="avatar-selection">
      {#each avatarOptions as avatar}
        <button type="button"
          class="avatar-option"
          class:avatar-selected={selectedAvatar === avatar.src}
          on:click={() => (selectedAvatar = avatar.src)}
        >
          <img src={avatar.src} alt={avatar.name} />
        </button>
      {/each}
    </div>
    
  {/if}
  <label for="username">Username:</label>
  <input type="text" name="username" bind:value={username} required />
  <label for="firstName">First name:</label>
  <input type="text" name="firstName" bind:value={firstName} required />

  <label for="lastName">Last name:</label>
  <input type="text" name="lastName" bind:value={lastName} required />

  <label for="email">Email:</label>
  <input type="email" name="email" bind:value={email} required />

  <label for="dob">Date of Birth:</label>
  <input type="date" name="dob" bind:value={dob} required />

  <label for="blurb">Blurb:</label>
  <textarea name="blurb" bind:value={blurb} rows="12" required></textarea>
  <button type="submit">Save</button>

  {#if error}<span class="error">Could not save!</span>{/if}
  {#if success}<span class="success">Saved!</span>{/if}
</form>
<button on:click|preventDefault={handleDeleteUser}>Delete Account</button>

<style>
  form {
    max-width: 500px;
    margin: 20px auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 8px;
    background-color: #f9f9f9;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  }

  label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
  }

  input[type="text"],
  input[type="email"],
  input[type="date"],
  textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
  }

  input:focus,
  textarea:focus {
    border-color: #66afe9;
    outline: none;
  }

  button[type="submit"] {
    background-color: #28a745;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
  }

  button[type="submit"]:hover {
    background-color: #218838;
  }

  img {
    width: 50px;
    height: 50px;
    border-radius: 50%;
  }
  .error {
    color: red;
    margin-top: 10px;
  }

  .success {
    color: green;
    margin-top: 10px;
  }

  button {
    background-color: #dc3545;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  button:hover {
    background-color: #c82333;
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
