### Running Websocket Container

```
docker run -e DB_HOST=mysql -e DB_DATABASE=bentaryo -e DB_USERNAME=bentaryo -e DB_PASSWORD=bentaryo_pass -e PUSHER_APP_ID=123 -e PUSHER_APP_KEY=456 -e PUSHER_APP_SECRET=678 --network bentaryo_net --name jcfranewebsockets --rm jcfranewebsockets
```
