<script>
  import { onMount } from "svelte";
  import { PUBLIC_API_BASE_URL } from "$env/static/public";

  export let isLoggedIn;
  export let article;
  $: likeCount = 0;
  $: hasLiked = false;

  async function fetchLikeData() {
    try {
      const response = await fetch(`${PUBLIC_API_BASE_URL}/articles/${article.id}/like-data`, {
        credentials: "include"
      });
      const data = await response.json();
      if (response.ok) {
        likeCount = data.likeCount;
        hasLiked = data.hasLiked;
      }
    } catch (error) {
      console.error("Error fetching like data:", error);
    }
  }

  async function handleLike() {
    if (!isLoggedIn) return;

    try {
      const method = hasLiked ? "DELETE" : "POST";
      const response = await fetch(`${PUBLIC_API_BASE_URL}/articles/${article.id}/like`, {
        method,
        credentials: "include"
      });

      if (response.ok) {
        await fetchLikeData();
      }
    } catch (error) {
      console.error("Error toggling like:", error);
    }
  }
  function shareWebpage() { 
    if (navigator.share) { 
      navigator.share({ 
        title: article.title, 
        text: article.summary, 
        url: window.location.href 
      }).then(() => { console.log('Thanks for sharing!');

       }).catch((error) => { 
        console.error('Error sharing:', error); 
      }); 
    } else { 
      console.log('Web Share API not supported in this browser.'); 
    } 
  }
  onMount(fetchLikeData);
  
</script>

<div class="like-container">
  <button
    class="like-button"
    title="Like this article"
    on:click={handleLike}
    disabled={!isLoggedIn}
  >
    {hasLiked ? "👎 Unlike" : "👍 Like"}
  </button>

  {#if likeCount > 0}
    <span class="like-count">{likeCount}</span>
  {/if}

  <button 
  class="share-button" 
  title="Share this article" 
  on:click={shareWebpage} 
  > 
  Share this Article
</button>
</div>

<style>
  .like-container {
    display: flex;
    align-items: center;
  }

  .like-button, .share-button {
    margin-right: 8px;
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    background-color: #f0f0f0;
    cursor: pointer;
    transition:
      background-color 0.3s,
      color 0.3s;
  }

  .like-button:hover, .share-button:hover {
    background-color: #e0e0e0;
    color: #007bff;
  }

  .like-button:disabled, .share-button {
    background-color: #ccc;
    cursor: not-allowed;
  }

  .like-count {
    font-weight: bold;
    color: #333;
  }

  .share-button {
    font-weight: bold;
    color:brown;
  }
  
  
</style>
