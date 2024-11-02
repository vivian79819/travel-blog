<script>
  import { createEventDispatcher } from "svelte";
  import QuillEditor from "./QuillEditor.svelte";
  export let article;
  const dispatch = createEventDispatcher();

  let title = article.title;
  let description = article.description;
  let content = article.content;
  let image = article.image;

  function handleSubmit() {
    const formData = new FormData();
    formData.append("title", title);
    formData.append("description", description);
    formData.append("content", content);
    if (image && image.length > 0) {
      formData.append("image", image[0]);
    }
    dispatch("submit", formData);
  }
</script>

<main>
  <form on:submit|preventDefault={handleSubmit} enctype="multipart/form-data">
    <div>
      <label for="title">Title:</label>
      <input id="title" bind:value={title} required />
    </div>
    <div>
      <label for="description">Description:</label>
      <textarea id="description" bind:value={description} required></textarea>
    </div>
    <div>
      <label for="content">Content:</label>
      <QuillEditor bind:content />
    </div>
    <div>
      <label for="image">Image:</label>
      {#if image}
        <p>Current image file: {article.image}</p>
      {/if}
      <p>If you would like to change the image, please re-upload.</p>
      <input type="file" id="image" bind:files={image} accept="image/*" />
    </div>
    <button type="submit">Save</button>
  </form>
</main>

<style>
  main {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
  }

  form {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }

  input,
  textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }

  button {
    padding: 8px 16px;
    background-color: var(--orange);
    color: white;
    border: none;
    border-radius: 4px;

    font-size: 1rem;
    transition: background-color 0.2s;

    &:hover {
      background-color: var(--beige);
      color: var(--orange);
      border: 1px solid var(--orange);
    }
  }
</style>
