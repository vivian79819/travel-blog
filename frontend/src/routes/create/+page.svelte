<script>
    import { PUBLIC_API_BASE_URL } from "$env/static/public";
    import { goto } from "$app/navigation";
  
    let title = "";
    let description = "";
    let content = "";
    let image;
  
    async function handleSubmit() {
      const formData = new FormData();
      formData.append("title", title);
      formData.append("description", description);
      formData.append("content", content);
      formData.append("image", image[0]);
  
      try {
        const response = await fetch(`${PUBLIC_API_BASE_URL}/articles`, {
          method: "POST",
          body: formData
        });
  
        if (response.ok) {
          const result = await response.json();
          goto(`/article/${result.id}`);
        } else {
          console.error("Failed to add article");
        }
      } catch (error) {
        console.error("Error adding article:", error);
      }
    }
  </script>
  
  <main>
    <h1>Add New Article</h1>
    <form on:submit|preventDefault={handleSubmit}>
      <div>
        <label for="title">Title:</label>
        <input id="title" bind:value={title} required>
      </div>
      <div>
        <label for="description">Description:</label>
        <textarea id="description" bind:value={description} required></textarea>
      </div>
      <div>
        <label for="content">Content:</label>
        <textarea id="content" bind:value={content} required></textarea>
      </div>
      <div>
        <label for="image">Image:</label>
        <input type="file" id="image" bind:files={image} accept="image/*" required>
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
  
    h1 {
      margin-bottom: 20px;
    }
  
    form {
      display: flex;
      flex-direction: column;
      gap: 16px;
    }
  
    label {
      font-weight: bold;
    }
  
    input, textarea {
      width: 100%;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
  
    textarea {
      min-height: 100px;
    }
  
    button {
      align-self: flex-start;
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