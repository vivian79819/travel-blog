<!-- src/lib/components/QuillEditor.svelte -->
<script>
    import { onMount } from 'svelte';
    import 'quill/dist/quill.snow.css'; // Import Quill's CSS
    import Quill from 'quill';
  
    export let content = ""; // The content that will sync with the parent component
    let editor;
    let editorContainer;

    // Initialize and customize Quill editor after the component mounts
    onMount(()=> {
      editor = new Quill (editorContainer, {
        theme: 'snow',
        placeholder: 'Compose your content here...',
        modules: {
          toolbar: [
          [{ 'header': [1, 2, 3, 4, 5, 6, false] }], // Size of text
          ['bold', 'italic', 'underline'], // Formatting options
          [{ 'color': [] }, { 'background': [] }], // Coloring options
          ['link', 'image'], // Link and Image options
          [{ list: 'bullet' }, { 'list': 'ordered'}, { 'list': 'check' }], // List style points
          ['clean'] // Clear formatting button
          ]
        }
        });
        // Load initial content
        editor.root.innerHTML = content;

        // Update content when Quill's content changes
        editor.on('text-change', () => {
            content = editor.root.innerHTML;
        });
    });
</script>

<div bind:this={editorContainer} class="quill-editor"></div>

<style>
  .quill-editor {
    min-height: 200px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
</style>