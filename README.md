# website_template
My Template to make website on my raspi server.

Providing login page, and template index.html.

## Usage

### Setup

1. Clone the repository:
```bash
git clone https://github.com/ChaelPix/web_file_transfert.git
cd web_file_transfert
```

2. Setup the environment:
```bash
bash setup_node_modules.sh
```

3. Generate .env :
```bash
bash utils/generate_env.sh
```

4. Build css:
```bash
npm run build
```

5. Start the server:
```bash
node server.js
```

6. Open your web browser and go to:
```
http://localhost:3000
```

### Deploy on Server

1. Copy to server if running on a local machine:
```bash
bash utils/copy_to_server.sh
```

2. Setup the service:
```bash
bash utils/setup_service.sh
```

3. Setup apache2 proxy:
```bash
bash utils/setup_apache2_proxy.sh
```
Then follow the instructions to enable the proxy and restart apache2.

### Customization

```js
const BASE = '/template_app'; // PATH ENDPOINT
const PORT = 3000;
```
Change `BASE` and `PORT` in `server.js`.

#### Edit Themes

Template using gradiant customizable in `input.css`.

