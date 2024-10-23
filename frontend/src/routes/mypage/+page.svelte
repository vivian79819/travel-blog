<script>
    export let data;
    $:articles=data.articles;
   const user=data.user;
   import { PUBLIC_IMAGES_URL } from "$env/static/public";

</script>
{#each articles as article}

<a href={`/article/${article.id}`} class="article-card">
    <img class="img" src={`${PUBLIC_IMAGES_URL}/${article.image}`} alt={article.title} />
    <div class="info">
      <h2>{article.title}</h2>
      <p class="desc">{article.description}</p>
     
        <p class="content">{article.content.substring(0, 120)}...</p>

      <div class="user">
        <img class="avatar" src={`${PUBLIC_IMAGES_URL}/${user.selectedAvatar}`} alt={user.username} />
        <div class="details">
          <span class="username">{user.username}</span>
          <span class="date">{article.date}</span>
        </div>
      </div>
    </div>
  </a>{/each}
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
    background-color: var(--grey-light);

    }
    .avatar{
      width:50px;
      height: 50px;
    }
  </style>