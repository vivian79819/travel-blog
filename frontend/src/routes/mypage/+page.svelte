<script>
  import UserArticle from "../../lib/components/UserArticle.svelte";
  export let data;
  $: articles = data.articles;
  const user = data.user;
  import { PUBLIC_IMAGES_URL } from "$env/static/public";
  
  // Add this console.log to check the data
  console.log('Data received:', data);
  </script>
  
  <!-- Add console logging of user data -->
  {#if data}
    {#if user}
      <div class="welcome">
        <h1>Welcome back, {user.firstName || 'User'}!</h1>
        <div class="info">
          {#if user.selectedAvatar}
            <img src={`${PUBLIC_IMAGES_URL}/${user.selectedAvatar}`} 
                 alt="{user.username}" 
                 class="avatar"/>
          {/if}
          <div class="details">
            <p class="username">@{user.username}</p>
            {#if user.blurb}
              <p class="blurb">{user.blurb}</p>
            {/if}
          </div>
        </div>
      </div>
    {/if}
  
    {#if articles && articles.length === 0}
      <p>You have not created any articles yet. Will you like to write one now?</p>
      <a href="/create" class="action-btn">Yes</a>
      <span>or</span>
      <a href="/" class="action-btn">Maybe later</a>
    {:else if articles}
      {#each articles as article}
        <UserArticle article={article} user={user} />
      {/each}
    {/if}
  {:else}
    <p>Loading...</p>
  {/if}
  
  <style>
  .action-btn {
    margin: 5px;
    padding: 8px 16px;
    text-decoration: none;
      background-color: var(--orange);
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 1rem;
      transition: background-color 0.2s;

      &:hover {background-color: var(--nuetral);
      color: var(--orange);
      border: 1px solid var(--orange);
  }

  }
  
  .welcome {
    margin-bottom: 2rem;
  }
  
  .info {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-top: 1rem;
  }
  
  .avatar {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    object-fit: cover;
  }
  
  .details {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
  
  .username {
    font-weight: bold;
    color: var(--orange);
  }
  
  .blurb {
    font-style: italic;
    color: #666;
  }
  </style>