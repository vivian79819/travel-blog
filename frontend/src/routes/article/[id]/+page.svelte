<script>
  import { PUBLIC_IMAGES_URL } from "$env/static/public";
  export let data;

  $: article = data.article;
</script>

<svelte:head>
  <title>Travel Blog</title>
</svelte:head>

<main>
  {#if article}
    <article>
      <h1>{article.title}</h1>
      <img src={`${PUBLIC_IMAGES_URL}/${article.image}`} alt={article.title} />
      <p class="info">
        By <span class="author">{article.username}</span> on <time>{article.date}</time>
      </p>
      <p class="desc">{article.description}</p>
      <div class="content">
        {article.content}
      </div>
    </article>
  {:else}
    <h1>Article Not Found</h1>
    <p>Sorry, we couldn't find the article you're looking for.</p>
    <a href="/">Go back to homepage</a>
  {/if}
</main>

<style>
  main {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
  }

  h1 {
    font-size: 2.5em;
    margin-bottom: 0.5em;
  }

  img {
    width: 100%;
    height: auto;
    margin-bottom: 1em;
  }

  .info {
    font-style: italic;
    color: #666;
  }

  .author {
    font-weight: bold;
  }

  .desc {
    font-size: 1.2em;
    margin: 1em 0;
  }

  .content {
    line-height: 1.6;
  }
</style>