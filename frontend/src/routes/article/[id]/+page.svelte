<script>
  import { PUBLIC_IMAGES_URL } from "$env/static/public";
  export let data;
  const id = data.articleId;
  const isLoggedIn = data.isLoggedIn;
  const user = data.user;
  import LikeButton from "$lib/components/LikeButton.svelte";
  import { goto } from "$app/navigation";

  function handleEditArticle() {
    goto(`/edit/${id}`);
  }

  async function handleShare() {
    const shareData = {
      title: article.title,
      text: article.description,
      url: window.location.href
    };
    if (navigator.share) {
      await navigator.share(shareData);
    }
  }

  function shareToFacebook() {
    window.open(`https://www.facebook.com/sharer/sharer.php?u=${window.location.href}`, "_blank");
  }

  function shareToTwitter() {
    window.open(`https://twitter.com/intent/tweet?url=${window.location.href}`, "_blank");
  }

  function shareToLinkedIn() {
    window.open(
      `https://www.linkedin.com/sharing/share-offsite/?url=${window.location.href}`,
      "_blank"
    );
  }

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
      <div class="share">
        <div class="left">
          <span class="label">Share this article:</span>
          <button class="share-button" on:click={handleShare}> Share </button>
          <div class="social-share">
            <button class="social-button facebook" on:click={shareToFacebook}>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="currentColor"
              >
                <path
                  d="M18.77 7.46H14.5v-1.9c0-.9.6-1.1 1-1.1h3V.5h-4.33C10.24.5 9.5 3.44 9.5 5.32v2.15h-3v4h3v12h5v-12h3.85l.42-4z"
                />
              </svg>
            </button>
            <button class="social-button twitter" on:click={shareToTwitter}>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="currentColor"
              >
                <path
                  d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"
                />
              </svg>
            </button>
            <button class="social-button linkedin" on:click={shareToLinkedIn}>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="currentColor"
              >
                <path
                  d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"
                />
              </svg>
            </button>
          </div>
        </div>
        <div class="like">
          <LikeButton {isLoggedIn} {article} />
        </div>
      </div>
      <p class="info">
        By <span class="author">{article.username}</span> on <time>{article.date}</time>
      </p>
      <p class="desc">{article.description}</p>
      <div class="content">{@html article.content}</div>
      {#if isLoggedIn && article.userId === user.id}
        <button class="edit-button" title="Edit your article" on:click={handleEditArticle}>
          Edit
        </button>
      {/if}
    </article>
  {:else}
    <h1>Article Not Found</h1>
    <p>Sorry, we couldn't find the article you're looking for.</p>
    <a href="/">Go back to homepage</a>
  {/if}
</main>

<style>
  main {
    position: relative;
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

  .share {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    padding: 0.5rem 0;
    margin-bottom: 1rem;
  }

  .left {
    display: flex;
    align-items: center;
    gap: 1rem;
  }

  .social-share {
    display: flex;
    gap: 0.5rem;
  }

  .share-button {
    padding: 8px 16px;
    background-color: var(--orange);
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    transition: background-color 0.2s;
  }

  .share-button:hover {
    background-color: var(--nuetral);
    color: var(--orange);
    border: 1px solid var(--orange);
  }

  .social-button {
    width: 36px;
    height: 36px;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: opacity 0.2s;
    color: white;
  }

  .social-button:hover {
    opacity: 0.9;
  }

  .social-button svg {
    width: 18px;
    height: 18px;
  }

  .facebook {
    background-color: #1877f2;
  }

  .twitter {
    background-color: #000000;
  }

  .linkedin {
    background-color: #0077b5;
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

  .edit-button {
    padding: 8px 16px;
    background-color: var(--orange);
    color: white;
    border: none;
    border-radius: 4px;

    font-size: 1rem;
    transition: background-color 0.2s;

    &:hover {
      background-color: var(--nuetral);
      color: var(--orange);
      border: 1px solid var(--orange);
    }
  }

  @media (max-width: 600px) {
    .share {
      flex-direction: column;
      align-items: flex-start;
      gap: 0.5rem;
    }

    .label {
      display: none;
    }
  }
</style>
