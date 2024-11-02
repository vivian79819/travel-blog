<script>
  import UserArticle from "../../lib/components/UserArticle.svelte";
  export let data;
  $: articles = data.articles;
  const user = data.user;
  import { PUBLIC_IMAGES_URL } from "$env/static/public";
</script>

{#if data}
  {#if user}
    <div class="welcome">
      <h1>Welcome back, {user.firstName || "User"}!</h1>
      <div class="info">
        {#if user.selectedAvatar}
          <img
            src={`${PUBLIC_IMAGES_URL}/${user.selectedAvatar}`}
            alt={user.username}
            class="avatar"
          />
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
    <div class="actions">
      <a href="/create" class="action-btn">Yes</a>
      <span>or</span>
      <a href="/" class="action-btn">Maybe later</a>
    </div>
  {:else if articles}
    <div class="articles-grid">
      {#each articles as article}
        <UserArticle {article} {user} />
      {/each}
    </div>
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

    font-size: 1rem;
    transition: background-color 0.2s;
  }

  .action-btn:hover {
    background-color: var(--nuetral);
    color: var(--orange);
    border: 1px solid var(--orange);
  }

  .welcome {
    margin-bottom: 40px;
    padding: 20px;
    background-color: var(--beige);
    border-radius: 8px;
  }

  .details p {
    color: black;
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

  .articles-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 24px;
    margin-top: 24px;
    margin-bottom: 24px;
  }

  .actions {
    margin-top: 1rem;
  }
</style>
