<script>
  export let data;
  $: articles = data.articles ;
  const user = data.user;
  import UserArticle from "../../lib/components/UserArticle.svelte";
</script>
{#if articles.length === 0}
  <p>You have not created any articles yet.</p>
{:else}
{#each articles as article}
<UserArticle article={article} user={user} />
{/each}
  {/if}

