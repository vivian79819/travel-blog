// import { PUBLIC_API_BASE_URL } from "$env/static/public";

// const MESSAGES_URL = `${PUBLIC_API_BASE_URL}/messages`;

/**
 * TODO Load your own data in the homepage here.
 *
 * You may need other *.js files with other load functions too.
 */
// export async function load({ fetch }) {
//   const response = await fetch(MESSAGES_URL, { credentials: "include" });
//   const messages = await response.json();
//   return { messages };
// }
import { PUBLIC_API_BASE_URL } from "$env/static/public";

const ARTICLES_URL = `${PUBLIC_API_BASE_URL}/articles`;

/**
 * TODO Load your own data in the homepage here.
 *
 * You may need other *.js files with other load functions too.
 */
export async function load({ fetch }) {
  const response = await fetch(ARTICLES_URL, { credentials: "include" });
  const articles = await response.json();
  return { articles };
}