<!-- src/lib/components/QuillEditor.svelte -->
<script>
  import { onMount, createEventDispatcher } from "svelte";

  const dispatch = createEventDispatcher();
  export let content = ""; // The content that will sync with the parent component
  let editor;

  // Initialize and customize Quill editor after the component mounts
  onMount(async () => {
    const { default: Quill } = await import("quill");
    await import("quill/dist/quill.snow.css");

    editor = new Quill("#editor", {
      theme: "snow",
      placeholder: "Compose your content here...",
      modules: {
        toolbar: [
          [{ header: [1, 2, 3, 4, 5, 6, false] }], // Size of text
          ["bold", "italic", "underline"], // Formatting options
          [{ color: [] }, { background: [] }], // Coloring options
          [{ list: "bullet" }, { list: "ordered" }, { list: "check" }], // List style points
          ["clean"] // Clear formatting button
        ]
      }
    });
    // Load initial content
    editor.root.innerHTML = content;

    // Update content when Quill's content changes
    editor.on("text-change", () => {
      content = editor.root.innerHTML;
      dispatch("input", content);
    });
  });
</script>

<div id="editor" style="min-height: 200px; border: 1px solid #ccc; padding: 10px;"></div>

<style>
  #editor {
    min-height: 200px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: white;
  }
</style>
