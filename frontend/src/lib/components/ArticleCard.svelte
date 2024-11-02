<script>
  import { PUBLIC_IMAGES_URL } from "$env/static/public";
  import DOMPurify from "dompurify";
  import truncate from "html-truncate";

  export let article;
  export let featured = false;

  // Sanitize and truncate the content
  const maxLength = 120; // Adjust this length as needed
  $: sanitizedContent = DOMPurify.sanitize(article.content || "");
  $: truncatedContent = truncate(sanitizedContent, maxLength);
</script>

<a href={`/article/${article.id}`} class="article-card {featured ? 'featured' : ''}">
  <img class="img" src={`${PUBLIC_IMAGES_URL}/${article.image}`} alt={article.title} />
  <div class="info">
    <h2>{article.title}</h2>
    <p class="desc">{article.description}</p>
    {#if featured && article.content}
      <!-- Render truncated and sanitized HTML content safely -->
      <p class="content">{@html truncatedContent}</p>
    {/if}
    <div class="user">
      <img
        class="avatar"
        src={`${PUBLIC_IMAGES_URL}/${article.userAvatar}`}
        alt={article.username}
      />
      <div class="details">
        <span class="username">{article.username}</span>
        <span class="date">{article.date}</span>
      </div>
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
    margin: 0 auto;
    background-color: white;
    text-decoration: none;
    color: inherit;
    background-color: white;
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
    color: black;
    line-height: 1.4;
  }

  .content {
    margin: 0 0 12px 0;
    font-size: 0.9rem;
    color: black;
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
    color: var(--dark-brown);
  }

  .date {
    font-size: 0.8rem;
    color: black;
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
  @media (max-width: 768px) {
    .featured {
      flex-direction: column;
      height: auto;
    }

    .featured .img {
      width: 100%;
      height: 200px;
    }

    .featured .info {
      width: 100%;
    }

    .featured h2,
    .featured .desc,
    .featured .content {
      word-wrap: break-word;
      overflow-wrap: break-word;
    }
  }
</style>
