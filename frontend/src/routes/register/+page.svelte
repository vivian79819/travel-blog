<script>
    import { goto } from "$app/navigation";
    import { PUBLIC_API_BASE_URL } from "$env/static/public";
    import NewUserForm from "$lib/components/NewUserForm.svelte";

    async function handleAddUser(e) {
    const user = e.detail;
   

    const response = await fetch(`${PUBLIC_API_BASE_URL}/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(user)
    });

    if (response.status === 201) {
        alert(`Created successfully!`);
        goto('/login');
    } else {
      alert(`Unexpected status code received: ${response.status}`);
    }
  }
</script>

<svelte:head>
  <title>Create Account</title>
</svelte:head>
<h2>Create Account</h2>

<NewUserForm on:submit={handleAddUser} />
<style>
  h2{
    text-align: center;
  }
</style>