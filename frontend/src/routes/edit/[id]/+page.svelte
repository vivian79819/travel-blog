<script>
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import EditArticle from "$lib/components/EditArticle.svelte";
  import { goto, invalidateAll } from "$app/navigation";

  export let data;
  $: article = data.article;
  async function handleEditArticle(e) {
    const articleData = e.detail;
    const response = await fetch(`${PUBLIC_API_BASE_URL}/articles/${article.id}`, {
      method: "PATCH",
      body: articleData,
      credentials: "include"
    });

    if (response.ok) {
      if (response.status !== 204) {
        const result = await response.json();
        await invalidateAll();
        goto(`/article/${result.id}`);
      } else {
        await invalidateAll();
        goto(`/article/${article.id}`);
      }
    } else {
      const errorText = await response.text();
      console.error("Failed to edit article:", errorText);
    }
  }
</script>

<svelte:head>
  <title>Edit Article</title>
</svelte:head>

<h1>My article</h1>

{#if article}
  <EditArticle {article} on:submit={handleEditArticle} />
{/if}

<style>
  h1 {
    text-align: center;
    font-size: 2rem;
    margin-top: 40px;
  }
</style>
