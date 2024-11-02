<script>
  import { createEventDispatcher } from "svelte";
  import QuillEditor from "./QuillEditor.svelte";

  const dispatch = createEventDispatcher();

  let title = "";
  let description = "";
  let content = "";
  let image;

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
  <div class="create-container">
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
        <input class="img" type="file" id="image" bind:files={image} accept="image/*" required />
      </div>
      <button type="submit">Add Article</button>
    </form>
  </div>
</main>

<style>
  main {
    margin-top: 100px;
    max-width: 800px;
    margin: 60px auto;
    padding: 20px;
  }

  form {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }

  .img {
    background-color: white;
    width: 98%;
  }

  input,
  textarea {
    width: 98%;
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
      background-color: var(--nuetral);
      color: var(--orange);
      border: 1px solid var(--orange);
    }
  }
</style>
