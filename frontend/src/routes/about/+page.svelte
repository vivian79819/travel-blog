<script>
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import UserInfoForm from "$lib/components/UserInfoForm.svelte";

  export let data;
</script>

<svelte:head>
  <title>About Me</title>
</svelte:head>

<h1>About me</h1>

{#if data.user}
  <UserInfoForm user={data.user} />
{/if}

<style>
  h1 {
    text-align: center;
    margin-top: 50px;
  }
</style>
