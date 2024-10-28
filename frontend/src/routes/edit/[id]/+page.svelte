<script>
  export let article;
  import { PUBLIC_API_BASE_URL } from "$env/static/public";
  import QuillEditor from "./QuillEditor.svelte";

  let title = article.title;
  let description = article.description;
  let content = article.content;
  let imageUrl = article.image;
  let newImageFile = null;

  function handleImageChange(e) {
    newImageFile = e.target.files[0];
  }

  async function handleSave() {
    const response = await fetch(`${PUBLIC_API_BASE_URL}/articles/${article.id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ title, description, content })
    });

    if (response.ok) {
      console.log("Article updated!");
    } else {
      console.error("Failed to update article");
    }
  }
</script>

<form on:submit|preventDefault={handleSave}>
  <label for="title">Title:</label>
  <input id="title" bind:value={title} />

  <label for="description">Description:</label>
  <input id="description" bind:value={description} />

  <label for="content">Content:</label>
  <QuillEditor bind:content />

  <div>
    <label for="image">Image:</label>
    <div class="image-preview">
      <img src={imageUrl} alt="Preview of the current article" class="current-image" />
    </div>
    <input type="file" id="image" on:change={handleImageChange} accept="image/*" />
  </div>

  <button type="submit">Save Changes</button>
</form>
