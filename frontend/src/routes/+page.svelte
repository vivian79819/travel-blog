

<script>
  import ArticleCard from '$lib/components/ArticleCard.svelte';
  import { PUBLIC_IMAGES_URL } from "$env/static/public";
  import MessageView from "$lib/components/MessageView.svelte";
  import SearchBox from '$lib/components/Search.svelte';
  import Banner from '../lib/components/Banner.svelte';
  export let data;
  $: articles = data.articles || [];
  $: userArticles = data.isLoggedIn ? articles.filter(article => article.userId === data.user.id) : [];
  $: otherArticles = data.isLoggedIn ? articles.filter(article => article.userId !== data.user.id) : articles;
  $: featuredArticle = otherArticles.length > 0 ? otherArticles[Math.floor(Math.random() * otherArticles.length)] : null;
  $: displayArticles = featuredArticle ? otherArticles.filter(article => article.id !== featuredArticle.id) : otherArticles;
</script>

<svelte:head>
  <title>Travel Blog</title>
</svelte:head>

<main>
  <Banner />
  <SearchBox {articles} />
  {#if data.isLoggedIn}
    <div class="welcome">
      <h1>Welcome back, {data.user.firstName}!</h1>
      <div class="info">
        <img src={`${PUBLIC_IMAGES_URL}/${data.user.selectedAvatar}`} alt="{data.user.username}" class="avatar"/>
        <div class="details">
          <p class="username">@{data.user.username}</p>
          <p class="blurb">{data.user.blurb}</p>
        </div>
      </div>
      
      <!-- {#if userArticles.length > 0}
        <section class="articles">
          <h2>My Travel Stories</h2>
          <div class="grid">
            {#each userArticles as article (article.id)}
              <ArticleCard {article} />
            {/each}
          </div>
        </section>
      {/if}  -->
      
      <div class="actions">
        <a href="/create" class="article-btn">Write New Travel Article</a>
      </div>
    </div>
  {/if}

  <section class="all-articles">
    <h2>Travel Stories</h2>
    
    {#if articles.length === 0}
      <p>Loading articles...</p>
    {:else}
      {#if featuredArticle}
        <section class="featured">
          <ArticleCard article={featuredArticle} featured={true} />
        </section>
      {/if}

      <section class="article-grid">
        {#each otherArticles as article (article.id)}
          <ArticleCard {article} />
        {/each}
      </section>
    {/if}
  </section>
</main>

<style>
  main {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
  }

  .welcome {
    margin-bottom: 40px;
    padding: 20px;
   
    background-color: var(--beige);
    border-radius: 8px;
  }

  h1 {
    margin: 0 0 20px 0;
    color: black;
  }

  h2 {
    margin: 20px 0;
    color: black;
    font-size: 40px;
  }

  .info {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
  }

  .avatar {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    margin-right: 15px;
  }

  .details {
    flex: 1;
  }

  .username {
    font-weight: bold;
    color: black;
    margin: 0;
  }

  .blurb {
    color: black;
    margin: 5px 0 0 0;
  }

  .actions {
    margin: 20px 0;
  }

  .article-btn {
    display: inline-block;
    padding: 10px 20px;
    background-color: var(--orange);
    color: white;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.2s;
  }

  .article-btn:hover {
    background-color: #0056b3;
  }



  .featured {
    margin-bottom: 40px;
    
    background-color: var(--neutral);
  }

  .article-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 24px;
    margin-top: 24px;
  }

  .all-articles {
    margin-top: 40px;
   
  }
</style>