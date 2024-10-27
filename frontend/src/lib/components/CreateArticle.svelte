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
      <input type="file" id="image" bind:files={image} accept="image/*" required />
    </div>
    <button type="submit">Add Article</button>
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
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  button:hover {
    background-color: #0056b3;
  }
</style>
