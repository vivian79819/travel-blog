
<script>
    import { PUBLIC_IMAGES_URL } from "$env/static/public";

    export let articles = [];
    
    let term = '';
    let results = [];
    let isActive = false;
    
    // this lets us control when the search is active
    function focus() {
      isActive = true;
    }
  
    // this lets us close the search and backgrogrand opacity effect
    function closeBackground() {
      isActive = false;
      term = '';
      results = [];
    }
    
    // reactively search
    $: {
      if (term.trim() === '') {
        results = [];
      } else {
        const search = term.toLowerCase();
        results = articles.filter(article => 
          article.title?.toLowerCase().includes(search) ||
          article.description?.toLowerCase().includes(search) ||
          article.content?.toLowerCase().includes(search) 
        ).slice(0, 8);
      }
    }
  </script>
  
  <!--adds the css overlay-->
  {#if isActive}
    <div class="overlay" on:click={closeBackground} />
  {/if}
  
  <div class="container">
    <input
      type="text"
      bind:value={term}
      placeholder="Search articles..."
      class="search-input"
      on:focus={focus}
    />
    
    {#if term.trim() && results.length > 0}
      <div class="results">
        {#each results as article}
          <a 
            href={`/article/${article.id}`} 
            class="card"
            on:click|stopPropagation
          >
            <div class="img-container">
              <img 
                src={`${PUBLIC_IMAGES_URL}/${article.image}`} 
                alt={article.title}
              />
            </div>
            <div class="content">
              <h3>{article.title}</h3>
              <p class="info">By {article.username} on {article.date}</p>
              <p class="desc">
                {article.description?.substring(0, 70)}
            {article.description?.length > 70 ? '...' : ''}
              </p>
            </div>
          </a>
        {/each}
      </div>
    {:else if term.trim()}
      <div class="no-results">
        <p>No articles found</p>
      </div>
    {/if}
  </div>
  
  <style>
    .overlay {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.7);
      z-index: 10;
      cursor: pointer;
    }
  
    .container {
      position: relative;
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
      z-index: 20;
    }
  
    .search-input {
      width: 100%;
      padding: 12px 16px;
      font-size: 16px;
      border: 2px solid #ddd;
      border-radius: 8px;
      margin-bottom: 8px;
      transition: all 0.2s;
      background: white;
    }
  
    .search-input:focus {
      border-color: #666;
      outline: none;

    }
  
    .results {
      position: absolute;
      width: 98%;
      background: white;
      border: 1px solid #ddd;
      border-radius: 8px;
      max-height: 500px;
      overflow-y: auto;
      margin: 0 auto;
    }
  
    .card {
      display: flex;
      padding: 12px;
      border-bottom: 1px solid #eee;
      text-decoration: none;
      color: inherit;
      transition: background-color 0.2s;
    }
  
    .card:hover {
      background-color: #f5f5f5;
    }
  
   
    .img-container {
      width: 100px;
      height: 70px;
      margin-right: 16px;

    }
  
    .img-container img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 4px;
    }
  
    .content h3 {
      margin: 0 0 4px 0;
      font-size: 1.1em;
    }
  
    .info {
      font-size: 0.9em;
      color: #666;
      margin: 0 0 4px 0;
    }
  
    .desc {
      font-size: 0.9em;
      margin: 0;

    }
  
    .no-results {
      padding: 16px;
      text-align: center;
      background: white;
      border: 1px solid #ddd;
      border-radius: 8px;
      width: 100%;
    }
  </style>
