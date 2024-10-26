<script>
  export let data;
  $: articles = data.articles ;
  const user = data.user;
  import UserArticle from "../../lib/components/UserArticle.svelte";
</script>

{#if articles.length === 0}
  <p>You have not created any articles yet. Will you like to write one now?</p>

  <!-- Link to create a new article -->
  <a href="/create" class="action-btn">Yes</a> 
  <span>or</span>
  <!-- Link to navigate back to the home page -->
  <a href= "/" class="action-btn">Maybe later</a>
  
{:else}
{#each articles as article}
<UserArticle article={article} user={user} />
{/each}
  {/if}

<style>
  .action-btn {
    color:white;
    background-color: rgb(247, 119, 141);
    padding: 10px;
    border: 3px solid rgb(211, 135, 211);
    text-decoration: none;
    border-radius: 10px;
    box-shadow: 3px 3px 5px rgba(168, 106, 106, 0.5);

    &:hover {
    background-color: rgb(244, 52, 84) ;
    }
  }
</style>
