<script>
  import { goto } from "$app/navigation";
  import { AUTH_URL } from "$lib/js/api-urls.js";

  let username = "";
  let password = "";
  let error = false;

  /**
   * Handles logging in by sending a POST request to /api/auth, with the given username and password.
   *
   * If successful, redirect the user back to the homepage. Otherwise, display an error message.
   */
  async function handleSubmit() {
    error = false;
    const response = await fetch(AUTH_URL, {
      method: "POST",
      credentials: "include",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ username, password })
    });

    if (response.status === 401) {
      error = true;
    } else {
      goto("/", { invalidateAll: true, replaceState: true });
    }
  }
</script>

<svelte:head>
  <title>Login</title>
</svelte:head>

<h1>Login</h1>

<form on:submit|preventDefault={handleSubmit}>
  <label for="username">Username:</label>
  <input type="text" name="username" bind:value={username} required />
  <label for="password">Password:</label>
  <input type="password" name="password" bind:value={password} required />
  <button type="submit">Login</button>
  {#if error}
    <span class="error">Could not log in with those credentials, please try again.</span>
  {/if}
</form>
<p>Don't have an Account? <a href="/register">Create yours now.</a></p>

<style>
  form {
    margin: 1rem auto;
    width: 360px;
    padding: 2rem;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    display: flex;
    flex-direction: column;
    gap: 1rem;
    border: none;
    box-sizing: border-box;
  }

  h1 {
    text-align: center;
    color: black;
    font-size: 2rem;
    margin: 30px 0 1.5rem 0;
  }

  label {
    display: block;
    margin-bottom: 0.5rem;
    color: black;
    font-weight: 500;
    font-size: 0.875rem;
  }

  input {
    width: 100%;
    padding: 0.75rem 1rem;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    background-color: #f8fafc;
    transition: border-color 0.15s ease;
    font-size: 1rem;
    box-sizing: border-box;
  }

  input:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
  }

  button {
    padding: 8px 16px;
    background-color: var(--orange);
    color: white;
    border: none;
    border-radius: 4px;

    font-size: 1rem;
    transition: background-color 0.2s;

    &:hover {
      background-color: var(--nuetral);
      color: var(--orange);
      border: 1px solid var(--orange);
    }
  }

  .error {
    background-color: var(--beige);
    border: 1px solid var(--neutral);
    color: black;
    padding: 0.75rem;
    border-radius: 6px;
    font-size: 0.875rem;
    text-align: center;
  }

  p {
    text-align: center;
    margin-top: 1.5rem;
    color: black;
  }

  a {
    color: var(--orange);
    text-decoration: none;
    font-weight: 500;
  }

  a:hover {
    text-decoration: underline;
  }
</style>
