<script>

  export let data;
</script>

<svelte:head>
  <title>Home</title>
</svelte:head>

<h1>Home</h1>

{#if data.isLoggedIn}
  <p>Hi {data.user.firstName}! Welcome to your personalized homepage!</p>
{:else}
  <p>position for all articles</p>
{/if}
