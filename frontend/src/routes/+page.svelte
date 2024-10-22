<script>
  import ArticleCard from '$lib/components/ArticleCard.svelte';
  import MessageView from "$lib/components/MessageView.svelte";
  export let data;

  $: articles = data.articles || [];
  $: featuredArticle = articles.length > 0 ? articles[Math.floor(Math.random() * articles.length)] : null;
  $: otherArticles = featuredArticle ? articles.filter(article => article.id !== featuredArticle.id) : [];
</script>

<svelte:head>
  <title>Travel Blog</title>
</svelte:head>

<main>
  {#if data.isLoggedIn}
  <p>Hi {data.user.firstName}! Welcome to your personalized homepage!</p>
{:else}
  <p>position for all articles</p>
{/if}
  {#if articles.length === 0}
    <p>Loading articles...</p>
  {:else}
    {#if featuredArticle}
      <section class="featured-article">
        <ArticleCard article={featuredArticle} featured={true} />
      </section>
    {/if}

    <section class="article-grid">
      {#each otherArticles as article (article.id)}
        <ArticleCard {article} />
      {/each}
    </section>
  {/if}
</main>

<style>
  main {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
  }

  .featured-article {
    margin-bottom: 40px;
  }

  .article-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 24px;
    margin-top: 24px;
  }
</style>
