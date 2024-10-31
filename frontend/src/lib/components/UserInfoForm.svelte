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
  max-width: 600px;
  margin: 1rem auto;
  padding: 2rem;
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  border: none;
  box-sizing: border-box;
}

.profile-display,
.edit-form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.avatar-container {
  display: flex;
  align-items: center;
  margin-bottom: 1rem;
}

.avatar-container button {
  background: none;
  border: none;
  padding: 0;
  margin-left: 0.75rem;
  cursor: pointer;
}

.user-info {
  margin-bottom: 1.5rem;
}

.dashed-line {
  border: none;
  border-top: 1px solid #e2e8f0;
  margin: 1.5rem 0;
}

.button-container {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
}

label {
  display: block;
  margin-bottom: 0.5rem;
  color: #4a5568;
  font-weight: 500;
  font-size: 0.875rem;
}

input[type="text"],
input[type="email"],
input[type="date"],
textarea {
  width: 100%;
  padding: 0.75rem 1rem;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  background-color: white;
  font-size: 0.875rem;
  margin-bottom: 1rem;
  box-sizing: border-box;
}

input:focus,
textarea:focus {
  outline: none;
  border-color: var(--orange);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}


.btn-save {
  padding: 8px 16px;
      background-color: var(--orange);
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 1rem;
      transition: background-color 0.2s;

      &:hover {background-color: var(--nuetral);
      color: var(--orange);
      border: 1px solid var(--orange);
}
}

.btn-delete, .btn-edit {
  padding: 8px 16px;
      background-color: var(--orange);
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 1rem;
      transition: background-color 0.2s;

      &:hover {background-color: var(--nuetral);
      color: var(--orange);
      border: 1px solid var(--orange);
  }
}
img {
  width: 40px;
  height: 40px;
  border-radius: 50%;
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
  cursor: pointer;
  background: none;
}

.avatar-selected {
  border-color: var(--orange);
}

.error {
  background-color: #fee2e2;
  border: 1px solid #fecaca;
  color: #dc2626;
  padding: 0.75rem;
  border-radius: 6px;
  font-size: 0.875rem;
  text-align: center;
}

.success {
  background-color: var(--orange);
  color: white;
  border: 1px solid #a7f3d0;
  padding: 0.75rem;
  border-radius: 6px;
  font-size: 0.875rem;
  text-align: center;
}

.confirm-delete {
  margin-top: 1rem;
  padding: 1rem;
  background-color: var(--beige);
   
  border-radius: 6px;
  text-align: center
}

.confirm-delete p {
  margin-bottom: 1rem;
  color: black;
}

.btn-confirm {
  background-color: var(--orange);
  margin-right: 0.5rem;
}

.btn-cancel {
  background-color: var(--orange);
}

.btn-confirm,
.btn-cancel {
  padding: 0.5rem 1rem;
  color: white;
  border: none;
  border-radius: 6px;
  font-weight: 500;
  font-size: 0.875rem;
  cursor: pointer;

  
  &:hover {background-color: var(--nuetral);
      color: var(--orange);
      border: 1px solid var(--orange);
  }
}
</style>
