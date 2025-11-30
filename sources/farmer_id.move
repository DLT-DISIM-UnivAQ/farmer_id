/*
/// Module: farmer_id
module farmer_id::farmer_id;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


module farmer_id::farmer_id {

    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::event;

    //
    // 1. Farmer Identity Object
    //
    public struct FarmerIdentity has key, store {
        id: UID,
        owner: address,
        farmer_name: vector<u8>,
        farm_location: vector<u8>,
        farm_size: u64,
        crop_type: vector<u8>,
        national_id: vector<u8>,
        certification: vector<u8>,
        active: bool
    }

    //
    // 2. Farmer event for auditing
    //
    public struct FarmerEvent has copy, drop {
        owner: address,
        action: vector<u8>
    }

    //
    // 3. Create Farmer Identity (No return → auto-transfer object)
    //
    public fun create_farmer_identity(
        farmer_name: vector<u8>,
        farm_location: vector<u8>,
        farm_size: u64,
        crop_type: vector<u8>,
        national_id: vector<u8>,
        certification: vector<u8>,
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);

        let obj = FarmerIdentity {
            id: object::new(ctx),
            owner: sender,
            farmer_name,
            farm_location,
            farm_size,
            crop_type,
            national_id,
            certification,
            active: true
        };

        // emit event
        event::emit(FarmerEvent {
            owner: sender,
            action: b"CREATED_FARMER_IDENTITY"
        });

        // AUTO-TRANSFER → fixes UnusedValueWithoutDrop error
        transfer::transfer(obj, sender);
    }

    //
    // 4. Update existing farmer identity
    //
    public fun update_farmer_identity(
        farmer: &mut FarmerIdentity,
        farmer_name: vector<u8>,
        farm_location: vector<u8>,
        farm_size: u64,
        crop_type: vector<u8>,
        certification: vector<u8>,
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);
        assert!(farmer.owner == sender, 100);

        farmer.farmer_name = farmer_name;
        farmer.farm_location = farm_location;
        farmer.farm_size = farm_size;
        farmer.crop_type = crop_type;
        farmer.certification = certification;

        event::emit(FarmerEvent {
            owner: sender,
            action: b"UPDATED_FARMER_IDENTITY"
        });
    }

    //
    // 5. Verify identity
    //
    public fun verify_farmer(farmer: &FarmerIdentity): bool {
        farmer.active
    }

    //
    // 6. Revoke identity (disable)
    //
    public fun revoke_farmer_identity(
        farmer: &mut FarmerIdentity,
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);
        assert!(farmer.owner == sender, 101);

        farmer.active = false;

        event::emit(FarmerEvent {
            owner: sender,
            action: b"REVOKED_FARMER_IDENTITY"
        });
    }

    //
    // 7. Optional: Transfer ownership to another address
    //
    public fun transfer_farmer_identity(
        farmer: FarmerIdentity,
        recipient: address
    ) {
        transfer::transfer(farmer, recipient);
    }
}
