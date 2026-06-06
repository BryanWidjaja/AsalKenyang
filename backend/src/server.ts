import { createApp } from "./app.js";
import { env } from "./lib/env.js";

const app = createApp();

app.listen(env.PORT, () => {
  console.log(`AsalKenyang API on http://localhost:${env.PORT}  (docs: /docs)`);
});
