<script>
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import { goto, invalidateAll } from "$app/navigation";
  import CreateArticle from "$lib/components/CreateArticle.svelte";

  async function handleAddArticle(e) {
    const articleData = e.detail;
    try {
      const response = await fetch(`${PUBLIC_API_BASE_URL}/articles`, {
        method: "POST",
        body: articleData,
        credentials: "include"
      });

      if (response.ok) {
        const result = await response.json();
        await invalidateAll();
        goto(`/article/${result.id}`);
      } else {
        const errorText = await response.text();
        console.error("Failed to add article:", errorText);
      }
    } catch (error) {
      console.error("Error adding article:", error);
    }
  }
</script>

<h1>Write an Article</h1>

<CreateArticle on:submit={handleAddArticle} />

<style>
  h1 {
    text-align: center;
    font-size: 2rem;
    margin-top: 50px;
  }
</style>
