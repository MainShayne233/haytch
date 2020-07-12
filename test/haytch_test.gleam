import haytch
import gleam/should

pub fn hello_world_test() {
  haytch.hello_world()
  |> should.equal("Hello, from haytch!")
}
