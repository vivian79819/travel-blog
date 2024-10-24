<script>
  import { invalidateAll, invalidate } from "$app/navigation";
  import { USER_URL } from "$lib/js/api-urls.js";
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import { goto } from "$app/navigation";
  import { AUTH_URL } from "$lib/js/api-urls.js";
  import { PUBLIC_IMAGES_URL } from "$env/static/public";

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
  let editing = false;

  let confirmingDelete = false;

  let avatarOptions = [
    { name: "Avatar 1", src: "avatars/avatar1.png" },
    { name: "Avatar 2", src: "avatars/avatar2.png" },
    { name: "Avatar 3", src: "avatars/avatar3.png" },
    { name: "Avatar 4", src: "avatars/avatar4.png" },
    { name: "Avatar 5", src: "avatars/avatar5.png" }
  ];

  async function handleSave() {
    console.log("Selected Avatar:", selectedAvatar);
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

    if (success) {
      invalidate(USER_URL);
      setTimeout(() => {
        editing = false;
        success = false;
      }, 1000);
    }
  }

  let deleteSuccess = false;
  let deleteError = false;

  async function handleDeleteUser(e) {
    const response = await fetch(`${PUBLIC_API_BASE_URL}/users/${user.id}`, {
      method: "DELETE"
    });

    if (response.status === 204) {
      deleteSuccess = true;
      deleteError = false;

      setTimeout(async () => {
        await fetch(AUTH_URL, {
          method: "DELETE",
          credentials: "include"
        });
        await invalidateAll();
        goto("/");
      }, 2000);
    } else {
      deleteError = true;
      deleteSuccess = false;
    }
  }

  function toggleAvatarSelection() {
    showAvatarSelector = !showAvatarSelector;
  }
  function handleDeleteClick() {
    confirmingDelete = true;
  }

  function cancelDelete() {
    confirmingDelete = false;
  }
</script>

<div class="user-profile">
  {#if !editing}
    <div class="profile-display">
      <div class="avatar-container">
        <p>Avatar:</p>
        <button type="button" on:click={() => toggleAvatarSelection()}>
          <img src={`${PUBLIC_IMAGES_URL}/${selectedAvatar}`} alt="Selected Avatar" />
        </button>
      </div>
      <div class="user-info">
        <p>Username: <strong>{username}</strong></p>
        <p>First name: <strong>{firstName}</strong></p>
        <p>Last name: <strong>{lastName}</strong></p>
        <p>Email: <strong>{email}</strong></p>
        <p>Date of Birth: <strong>{dob}</strong></p>
        <p>Blurb: <strong>{blurb}</strong></p>
        <hr class="dashed-line" />
      </div>
      <div class="button-container">
        <button on:click={() => (editing = true)} class="btn-edit">Edit</button>
        <button on:click|preventDefault={handleDeleteClick} class="btn-delete"
          >Delete Account</button
        >
      </div>
    </div>
    {#if confirmingDelete}
      <div class="confirm-delete">
        <p>Are you sure you want to delete your account?</p>
        <button on:click={handleDeleteUser} class="btn-confirm">Confirm</button>
        <button on:click={cancelDelete} class="btn-cancel">Cancel</button>
      </div>
    {/if}
  {:else}
    <form on:submit|preventDefault={handleSave} class="edit-form">
      <div class="avatar-container">
        <p>Your Avatar:</p>
        <button type="button" on:click={() => toggleAvatarSelection()}>
          <img src={`${PUBLIC_IMAGES_URL}/${selectedAvatar}`} alt="Selected Avatar" />
        </button>
      </div>
      {#if showAvatarSelector}
        <label for="avatar">Choose an avatar:</label>
        <div class="avatar-selection">
          {#each avatarOptions as avatar}
            <button
              type="button"
              class="avatar-option"
              class:avatar-selected={selectedAvatar === avatar.src}
              on:click={() => {
                selectedAvatar = avatar.src;
                showAvatarSelector = false;
              }}
            >
              <img src={`${PUBLIC_IMAGES_URL}/${avatar.src}`} alt={avatar.name} />
            </button>
          {/each}
        </div>
      {/if}
      <label for="username">Username:</label>
      <input type="text" name="username" bind:value={username} required disabled />

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

      <button type="submit" class="btn-save">Save</button>

      {#if error}<span class="error">Could not save!</span>{/if}
      {#if success}<span class="success">Saved!</span>{/if}
    </form>
  {/if}

  {#if deleteSuccess}<span class="success">Account deleted! Redirecting...</span>{/if}
  {#if deleteError}<span class="error">Could not delete account!</span>{/if}
</div>

<style>
  .user-profile {
    max-width: 500px;
    margin: 20px auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  }

  .profile-display,
  .edit-form {
    display: flex;
    flex-direction: column;
  }

  .avatar-container {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
  }

  .avatar-container button {
    margin-left: 10px;
  }

  .user-info {
    margin-bottom: 15px;
  }

  .dashed-line {
    border-top: 1px dashed #ccc;
    margin: 10px 0;
  }

  .button-container {
    display: flex;
    justify-content: space-between;
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
    margin-left: 10px;
  }

  input:focus,
  textarea:focus {
    border-color: #66afe9;
    outline: none;
  }

  button[type="submit"],
  .btn-edit,
  .btn-delete {
    background-color: rgb(178, 168, 234);
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
  }

  button[type="submit"]:hover,
  .btn-edit:hover,
  .btn-delete:hover {
    background-color: #0056b3;
  }

  img {
    width: 50px;
    height: 50px;
    border-radius: 50%;
  }

  .error {
    color: red;
    margin-top: 10px;
    font-weight: bold;
    font-size: 1.2em;
  }

  .success {
    color: green;
    margin-top: 10px;
    font-weight: bold;
    font-size: 1.2em;
  }

  .edit-form {
    padding: 20px;
  }
</style>
