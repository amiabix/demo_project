#[starknet::contract]
mod SimpleContract {
    #[storage]
    struct Storage {
        balance: felt252, 
    }
    
    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn internal_function(self: @ContractState) -> felt252 {
            self.balance.read()
        }
    }

    fn other_internal_function(self: @ContractState) -> felt252 {
        self.balance.read() + 5
    }
}

use SimpleContract::{ InternalTrait, other_internal_function };

fn add(a: felt252, b: felt252, c: felt252) -> felt252 {
    a + b + c
}

fn main() -> felt252 {
    let mut state = SimpleContract::contract_state_for_testing();
    state.balance.write(10);
  
    let balance = state.balance.read();
    let internal_balance = state.internal_function();
    let other_balance = other_internal_function(@state);
    
    let res = add(balance, internal_balance, other_balance);
    res
}