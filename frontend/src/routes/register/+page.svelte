<script>
  import { goto } from "$app/navigation";
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import NewUserForm from "$lib/components/NewUserForm.svelte";
  let success = false;
  let error = false;
  let warning = "";
  async function handleAddUser(e) {
    const user = e.detail;

    const response = await fetch(`${PUBLIC_API_BASE_URL}/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(user)
    });

    if (response.status === 201) {
      success = true;
      error = false;
      warning = "Account created successfully! Redirecting to login page...";
      // Redirect to login page
      setTimeout(() => {
        goto("/login");
      }, 2000); // Optional delay before redirecting
    } else if (response.status === 422) {
      success = false;
      error = true;
      warning = "There was an issue with your input. Please check the form and try again.";
    } else {
      success = false;
      error = true;
      warning = `Unexpected status code received: ${response.status}`;
    }
  }
</script>

<svelte:head>
  <title>Create Account</title>
</svelte:head>

<h2>Create Account</h2>
<div class="sign-up">
  <NewUserForm on:submit={handleAddUser} />
  {#if success}
    <p style="color: green;">{warning}</p>
  {/if}

  {#if error}
    <p style="color: red;">{warning}</p>
  {/if}
</div>

<style>
  h2 {
    text-align: center;
    color: #1a1a1a;
    font-size: 2rem;
    margin: 30px 0 1.5rem 0;
  }

  .sign-up {
    margin: 1rem auto;
    padding: 2rem;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    display: flex;
    flex-direction: column;
    gap: 1rem;
    border: none;
    min-height: calc(100vh - 4rem);
    padding-bottom: 50px;
  }

  p {
    grid-column: 1 / 3;
    font-weight: bold;
    padding: 5px;
    text-align: center;
  }
</style>
