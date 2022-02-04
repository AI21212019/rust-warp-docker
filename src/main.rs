use warp::Filter;

#[tokio::main]
async fn main() {
    println!("Starting server...");
    let root = warp::path::end().map(|| "Welcome to my tiny efficiently dockerized new warp server!");

    let routes = root.with(warp::cors().allow_any_origin());

    warp::serve(routes).run(([0, 0, 0, 0], 5000)).await;
}
