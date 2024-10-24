<script>
  export let article;
  export let user;
  import { PUBLIC_IMAGES_URL, PUBLIC_API_BASE_URL } from "$env/static/public";
  import { goto } from "$app/navigation";
  let featured = false;

  async function handleDelete() {
  try {
    const response = await fetch(`${PUBLIC_API_BASE_URL}/articles/${article.id}`, {
      method: "DELETE",
      credentials: "include"
    });
    if (response.ok) {
      goto('/articles');
    } else {
      console.error(response.status);
    }
  } catch (error) {
    console.error( error);
  }
}
</script>

<a href={`/article/${article.id}`} class="article-card {featured ? 'featured' : ''}">
  <img class="img" src={`${PUBLIC_IMAGES_URL}/${article.image}`} alt={article.title} />
  <div class="info">
    <h2>{article.title}</h2>
    <p class="desc">{article.description}</p>
    {#if featured}
      <p class="content">{article.content.substring(0, 120)}...</p>
    {/if}
    <div class="user">
      <img class="avatar" src={`${PUBLIC_IMAGES_URL}/${user.selectedAvatar}`} alt={user.username} />
      <div class="details">
        <span class="username">{user.username}</span>
        <span class="date">{article.date}</span>
      </div>
    </div>

    <div class="action-buttons">
      <button class="edit-button" title="Edit your article" on:click|preventDefault>Edit</button>
      <button class="delete-button" title="Delete your article" on:click|preventDefault={handleDelete}
        >Delete</button
      >
    </div>
  </div>
</a>

<style>
  .article-card {
    display: flex;
    flex-direction: column;
    border-radius: 4px;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    transition: box-shadow 0.2s ease-in-out;
    width: 100%;
    max-width: 360px;
    margin: 20px auto;
    background-color: white;
    text-decoration: none;
    color: inherit;
    background-color: var(--grey-light);
    position: relative;
  }

  .article-card:hover {
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
  }

  .img {
    width: 100%;
    height: 200px;
    object-fit: cover;
  }

  .info {
    padding: 16px;
  }

  h2 {
    margin: 0 0 8px 0;
    font-size: 1.2rem;
    line-height: 1.3;
    font-weight: 600;
  }

  .desc {
    margin: 0 0 12px 0;
    font-size: 0.9rem;
    color: #555;
    line-height: 1.4;
  }

  .content {
    margin: 0 0 12px 0;
    font-size: 0.9rem;
    color: #333;
    line-height: 1.4;
  }

  .user {
    display: flex;
    align-items: center;
  }

  .avatar {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    margin-right: 8px;
  }

  .details {
    display: flex;
    align-items: center;
  }

  .username {
    font-size: 0.8rem;
    font-weight: 500;
    margin-right: 8px;
    color: var(--purple-dark);
  }

  .date {
    font-size: 0.8rem;
    color: #777;
  }

  .featured {
    flex-direction: row;
    max-width: 100%;
    height: 280px;
  }

  .featured .img {
    width: 50%;
    height: 100%;
  }

  .featured .info {
    width: 50%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

  .featured h2 {
    font-size: 1.5rem;
    margin-bottom: 12px;
  }

  .featured .desc,
  .featured .content {
    font-size: 1rem;
  }

  .featured .avatar {
    width: 24px;
    height: 24px;
  }

  .featured .username,
  .featured .date {
    font-size: 0.9rem;
  }

  /* Action buttons styling */
  .action-buttons {
    margin-top: 10px;
    display: flex;
    justify-content: flex-end;
    gap: 10px;
  }

  .edit-button,
  .delete-button {
    background-color: var(--purple-dark);
    color: white;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
    border-radius: 3px;
    font-size: 0.8rem;
  }

  .delete-button {
    background-color: #ff5555;
  }

  .edit-button:hover,
  .delete-button:hover {
    opacity: 0.8;
  }

  .edit-button,
  .delete-button {
    z-index: 10;
    position: relative;
  }
</style>
