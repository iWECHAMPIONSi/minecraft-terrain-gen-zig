//! String-only Minecraft names/registry identifiers.
//! Kept separate from typed compile-time data so Zig declaration names stay idiomatic.

// =============================================================================
// String namespaces
// =============================================================================

pub const IdentifierStrings = struct {
    pub const default_namespace: []const u8 = "minecraft";
    pub const realms_namespace: []const u8 = "realms";
    pub const allowed_namespace_characters: []const u8 = "[a-z0-9_.-]";
    pub const root_registry: []const u8 = "root";
    pub const noise_registry: []const u8 = "worldgen/noise";
    pub const biome_registry: []const u8 = "worldgen/biome";
};

pub const DirectionStrings = struct {
    pub const down: []const u8 = "down";
    pub const up: []const u8 = "up";
    pub const north: []const u8 = "north";
    pub const south: []const u8 = "south";
    pub const west: []const u8 = "west";
    pub const east: []const u8 = "east";
};

pub const DirectionAxisStrings = struct {
    pub const x: []const u8 = "x";
    pub const y: []const u8 = "y";
    pub const z: []const u8 = "z";
};

pub const DirectionAxisDirectionStrings = struct {
    pub const positive: []const u8 = "Towards positive";
    pub const negative: []const u8 = "Towards negative";
};

pub const RotationStrings = struct {
    pub const none: []const u8 = "none";
    pub const clockwise_90: []const u8 = "clockwise_90";
    pub const clockwise_180: []const u8 = "180";
    pub const counterclockwise_90: []const u8 = "counterclockwise_90";
};

pub const MirrorStrings = struct {
    pub const none: []const u8 = "none";
    pub const left_right: []const u8 = "left_right";
    pub const front_back: []const u8 = "front_back";
};

pub const BiomePrecipitationStrings = struct {
    pub const none: []const u8 = "none";
    pub const rain: []const u8 = "rain";
    pub const snow: []const u8 = "snow";
};

pub const BiomeTemperatureModifierStrings = struct {
    pub const none: []const u8 = "none";
    pub const frozen: []const u8 = "frozen";
};

pub const BiomeGrassColorModifierStrings = struct {
    pub const none: []const u8 = "none";
    pub const dark_forest: []const u8 = "dark_forest";
    pub const swamp: []const u8 = "swamp";
};

pub const HeightmapTypeStrings = struct {
    pub const world_surface_wg: []const u8 = "WORLD_SURFACE_WG";
    pub const world_surface: []const u8 = "WORLD_SURFACE";
    pub const ocean_floor_wg: []const u8 = "OCEAN_FLOOR_WG";
    pub const ocean_floor: []const u8 = "OCEAN_FLOOR";
    pub const motion_blocking: []const u8 = "MOTION_BLOCKING";
    pub const motion_blocking_no_leaves: []const u8 = "MOTION_BLOCKING_NO_LEAVES";
};

pub const CaveSurfaceStrings = struct {
    pub const ceiling: []const u8 = "ceiling";
    pub const floor: []const u8 = "floor";
};

pub const DensityMarkerTypeStrings = struct {
    pub const interpolated: []const u8 = "interpolated";
    pub const flat_cache: []const u8 = "flat_cache";
    pub const cache_2d: []const u8 = "cache_2d";
    pub const cache_once: []const u8 = "cache_once";
    pub const cache_all_in_cell: []const u8 = "cache_all_in_cell";
    pub const blend_density: []const u8 = "blend_density";
};

pub const DensityMappedTypeStrings = struct {
    pub const abs: []const u8 = "abs";
    pub const square: []const u8 = "square";
    pub const cube: []const u8 = "cube";
    pub const half_negative: []const u8 = "half_negative";
    pub const quarter_negative: []const u8 = "quarter_negative";
    pub const invert: []const u8 = "invert";
    pub const squeeze: []const u8 = "squeeze";
};

pub const DensityTwoArgumentTypeStrings = struct {
    pub const add: []const u8 = "add";
    pub const mul: []const u8 = "mul";
    pub const min: []const u8 = "min";
    pub const max: []const u8 = "max";
};

pub const BambooLeavesStrings = struct {
    pub const none: []const u8 = "none";
    pub const small: []const u8 = "small";
    pub const large: []const u8 = "large";
};

pub const CreakingHeartStateStrings = struct {
    pub const uprooted: []const u8 = "uprooted";
    pub const dormant: []const u8 = "dormant";
    pub const awake: []const u8 = "awake";
};

pub const DoubleBlockHalfStrings = struct {
    pub const upper: []const u8 = "upper";
    pub const lower: []const u8 = "lower";
};

pub const PotentSulfurStateStrings = struct {
    pub const dry: []const u8 = "dry";
    pub const wet: []const u8 = "wet";
    pub const dormant: []const u8 = "dormant";
    pub const erupting: []const u8 = "erupting";
    pub const continuous: []const u8 = "continuous";
};

pub const SpeleothemThicknessStrings = struct {
    pub const tip_merge: []const u8 = "tip_merge";
    pub const tip: []const u8 = "tip";
    pub const frustum: []const u8 = "frustum";
    pub const middle: []const u8 = "middle";
    pub const base: []const u8 = "base";
};

pub const MobCategoryStrings = struct {
    pub const monster: []const u8 = "monster";
    pub const creature: []const u8 = "creature";
    pub const ambient: []const u8 = "ambient";
    pub const axolotls: []const u8 = "axolotls";
    pub const underground_water_creature: []const u8 = "underground_water_creature";
    pub const water_creature: []const u8 = "water_creature";
    pub const water_ambient: []const u8 = "water_ambient";
    pub const misc: []const u8 = "misc";
};

pub const MobCategoryDebugStrings = struct {
    pub const monster: []const u8 = "MO";
    pub const creature: []const u8 = "C";
    pub const ambient: []const u8 = "AM";
    pub const axolotls: []const u8 = "AX";
    pub const underground_water_creature: []const u8 = "UWC";
    pub const water_creature: []const u8 = "WC";
    pub const water_ambient: []const u8 = "WA";
    pub const misc: []const u8 = "MI";
};

pub const IntProviderTypeStrings = struct {
    pub const constant: []const u8 = "constant";
    pub const uniform: []const u8 = "uniform";
    pub const biased_to_bottom: []const u8 = "biased_to_bottom";
    pub const clamped: []const u8 = "clamped";
    pub const weighted_list: []const u8 = "weighted_list";
    pub const clamped_normal: []const u8 = "clamped_normal";
    pub const trapezoid: []const u8 = "trapezoid";
};

pub const FloatProviderTypeStrings = struct {
    pub const constant: []const u8 = "constant";
    pub const uniform: []const u8 = "uniform";
    pub const clamped_normal: []const u8 = "clamped_normal";
    pub const trapezoid: []const u8 = "trapezoid";
};

pub const HeightProviderTypeStrings = struct {
    pub const constant: []const u8 = "constant";
    pub const uniform: []const u8 = "uniform";
    pub const biased_to_bottom: []const u8 = "biased_to_bottom";
    pub const very_biased_to_bottom: []const u8 = "very_biased_to_bottom";
    pub const trapezoid: []const u8 = "trapezoid";
    pub const weighted_list: []const u8 = "weighted_list";
};

pub const NoisePathStrings = struct {
    pub const temperature: []const u8 = "temperature";
    pub const vegetation: []const u8 = "vegetation";
    pub const continentalness: []const u8 = "continentalness";
    pub const erosion: []const u8 = "erosion";
    pub const temperature_large: []const u8 = "temperature_large";
    pub const vegetation_large: []const u8 = "vegetation_large";
    pub const continentalness_large: []const u8 = "continentalness_large";
    pub const erosion_large: []const u8 = "erosion_large";
    pub const ridge: []const u8 = "ridge";
    pub const shift: []const u8 = "offset";
    pub const temperature_nether: []const u8 = "nether/temperature";
    pub const vegetation_nether: []const u8 = "nether/vegetation";
    pub const aquifer_barrier: []const u8 = "aquifer_barrier";
    pub const aquifer_fluid_level_floodedness: []const u8 = "aquifer_fluid_level_floodedness";
    pub const aquifer_lava: []const u8 = "aquifer_lava";
    pub const aquifer_fluid_level_spread: []const u8 = "aquifer_fluid_level_spread";
    pub const pillar: []const u8 = "pillar";
    pub const pillar_rareness: []const u8 = "pillar_rareness";
    pub const pillar_thickness: []const u8 = "pillar_thickness";
    pub const spaghetti_2d: []const u8 = "spaghetti_2d";
    pub const spaghetti_2d_elevation: []const u8 = "spaghetti_2d_elevation";
    pub const spaghetti_2d_modulator: []const u8 = "spaghetti_2d_modulator";
    pub const spaghetti_2d_thickness: []const u8 = "spaghetti_2d_thickness";
    pub const spaghetti_3d_1: []const u8 = "spaghetti_3d_1";
    pub const spaghetti_3d_2: []const u8 = "spaghetti_3d_2";
    pub const spaghetti_3d_rarity: []const u8 = "spaghetti_3d_rarity";
    pub const spaghetti_3d_thickness: []const u8 = "spaghetti_3d_thickness";
    pub const spaghetti_roughness: []const u8 = "spaghetti_roughness";
    pub const spaghetti_roughness_modulator: []const u8 = "spaghetti_roughness_modulator";
    pub const cave_entrance: []const u8 = "cave_entrance";
    pub const cave_layer: []const u8 = "cave_layer";
    pub const cave_cheese: []const u8 = "cave_cheese";
    pub const ore_veininess: []const u8 = "ore_veininess";
    pub const ore_vein_a: []const u8 = "ore_vein_a";
    pub const ore_vein_b: []const u8 = "ore_vein_b";
    pub const ore_gap: []const u8 = "ore_gap";
    pub const noodle: []const u8 = "noodle";
    pub const noodle_thickness: []const u8 = "noodle_thickness";
    pub const noodle_ridge_a: []const u8 = "noodle_ridge_a";
    pub const noodle_ridge_b: []const u8 = "noodle_ridge_b";
    pub const jagged: []const u8 = "jagged";
    pub const surface: []const u8 = "surface";
    pub const surface_secondary: []const u8 = "surface_secondary";
    pub const clay_bands_offset: []const u8 = "clay_bands_offset";
    pub const badlands_pillar: []const u8 = "badlands_pillar";
    pub const badlands_pillar_roof: []const u8 = "badlands_pillar_roof";
    pub const badlands_surface: []const u8 = "badlands_surface";
    pub const iceberg_pillar: []const u8 = "iceberg_pillar";
    pub const iceberg_pillar_roof: []const u8 = "iceberg_pillar_roof";
    pub const iceberg_surface: []const u8 = "iceberg_surface";
    pub const sulfur_cave_gradient: []const u8 = "sulfur_cave_gradient";
    pub const swamp: []const u8 = "surface_swamp";
    pub const calcite: []const u8 = "calcite";
    pub const gravel: []const u8 = "gravel";
    pub const powder_snow: []const u8 = "powder_snow";
    pub const packed_ice: []const u8 = "packed_ice";
    pub const ice: []const u8 = "ice";
    pub const soul_sand_layer: []const u8 = "soul_sand_layer";
    pub const gravel_layer: []const u8 = "gravel_layer";
    pub const patch: []const u8 = "patch";
    pub const netherrack: []const u8 = "netherrack";
    pub const nether_wart: []const u8 = "nether_wart";
    pub const nether_state_selector: []const u8 = "nether_state_selector";
};

pub const BiomePathStrings = struct {
    pub const the_void: []const u8 = "the_void";
    pub const plains: []const u8 = "plains";
    pub const sunflower_plains: []const u8 = "sunflower_plains";
    pub const snowy_plains: []const u8 = "snowy_plains";
    pub const ice_spikes: []const u8 = "ice_spikes";
    pub const desert: []const u8 = "desert";
    pub const swamp: []const u8 = "swamp";
    pub const mangrove_swamp: []const u8 = "mangrove_swamp";
    pub const forest: []const u8 = "forest";
    pub const flower_forest: []const u8 = "flower_forest";
    pub const birch_forest: []const u8 = "birch_forest";
    pub const dark_forest: []const u8 = "dark_forest";
    pub const pale_garden: []const u8 = "pale_garden";
    pub const old_growth_birch_forest: []const u8 = "old_growth_birch_forest";
    pub const old_growth_pine_taiga: []const u8 = "old_growth_pine_taiga";
    pub const old_growth_spruce_taiga: []const u8 = "old_growth_spruce_taiga";
    pub const taiga: []const u8 = "taiga";
    pub const snowy_taiga: []const u8 = "snowy_taiga";
    pub const savanna: []const u8 = "savanna";
    pub const savanna_plateau: []const u8 = "savanna_plateau";
    pub const windswept_hills: []const u8 = "windswept_hills";
    pub const windswept_gravelly_hills: []const u8 = "windswept_gravelly_hills";
    pub const windswept_forest: []const u8 = "windswept_forest";
    pub const windswept_savanna: []const u8 = "windswept_savanna";
    pub const jungle: []const u8 = "jungle";
    pub const sparse_jungle: []const u8 = "sparse_jungle";
    pub const bamboo_jungle: []const u8 = "bamboo_jungle";
    pub const badlands: []const u8 = "badlands";
    pub const eroded_badlands: []const u8 = "eroded_badlands";
    pub const wooded_badlands: []const u8 = "wooded_badlands";
    pub const meadow: []const u8 = "meadow";
    pub const cherry_grove: []const u8 = "cherry_grove";
    pub const grove: []const u8 = "grove";
    pub const snowy_slopes: []const u8 = "snowy_slopes";
    pub const frozen_peaks: []const u8 = "frozen_peaks";
    pub const jagged_peaks: []const u8 = "jagged_peaks";
    pub const stony_peaks: []const u8 = "stony_peaks";
    pub const river: []const u8 = "river";
    pub const frozen_river: []const u8 = "frozen_river";
    pub const beach: []const u8 = "beach";
    pub const snowy_beach: []const u8 = "snowy_beach";
    pub const stony_shore: []const u8 = "stony_shore";
    pub const warm_ocean: []const u8 = "warm_ocean";
    pub const lukewarm_ocean: []const u8 = "lukewarm_ocean";
    pub const deep_lukewarm_ocean: []const u8 = "deep_lukewarm_ocean";
    pub const ocean: []const u8 = "ocean";
    pub const deep_ocean: []const u8 = "deep_ocean";
    pub const cold_ocean: []const u8 = "cold_ocean";
    pub const deep_cold_ocean: []const u8 = "deep_cold_ocean";
    pub const frozen_ocean: []const u8 = "frozen_ocean";
    pub const deep_frozen_ocean: []const u8 = "deep_frozen_ocean";
    pub const mushroom_fields: []const u8 = "mushroom_fields";
    pub const dripstone_caves: []const u8 = "dripstone_caves";
    pub const lush_caves: []const u8 = "lush_caves";
    pub const deep_dark: []const u8 = "deep_dark";
    pub const sulfur_caves: []const u8 = "sulfur_caves";
    pub const nether_wastes: []const u8 = "nether_wastes";
    pub const warped_forest: []const u8 = "warped_forest";
    pub const crimson_forest: []const u8 = "crimson_forest";
    pub const soul_sand_valley: []const u8 = "soul_sand_valley";
    pub const basalt_deltas: []const u8 = "basalt_deltas";
    pub const the_end: []const u8 = "the_end";
    pub const end_highlands: []const u8 = "end_highlands";
    pub const end_midlands: []const u8 = "end_midlands";
    pub const small_end_islands: []const u8 = "small_end_islands";
    pub const end_barrens: []const u8 = "end_barrens";
};

pub const BlockPropertyStrings = struct {
    pub const attached: []const u8 = "attached";
    pub const berries: []const u8 = "berries";
    pub const bloom: []const u8 = "bloom";
    pub const bottom: []const u8 = "bottom";
    pub const can_summon: []const u8 = "can_summon";
    pub const conditional: []const u8 = "conditional";
    pub const disarmed: []const u8 = "disarmed";
    pub const drag: []const u8 = "drag";
    pub const enabled: []const u8 = "enabled";
    pub const extended: []const u8 = "extended";
    pub const eye: []const u8 = "eye";
    pub const falling: []const u8 = "falling";
    pub const hanging: []const u8 = "hanging";
    pub const has_bottle_0: []const u8 = "has_bottle_0";
    pub const has_bottle_1: []const u8 = "has_bottle_1";
    pub const has_bottle_2: []const u8 = "has_bottle_2";
    pub const has_record: []const u8 = "has_record";
    pub const has_book: []const u8 = "has_book";
    pub const inverted: []const u8 = "inverted";
    pub const in_wall: []const u8 = "in_wall";
    pub const lit: []const u8 = "lit";
    pub const locked: []const u8 = "locked";
    pub const natural: []const u8 = "natural";
    pub const occupied: []const u8 = "occupied";
    pub const open: []const u8 = "open";
    pub const persistent: []const u8 = "persistent";
    pub const powered: []const u8 = "powered";
    pub const short: []const u8 = "short";
    pub const shrieking: []const u8 = "shrieking";
    pub const signal_fire: []const u8 = "signal_fire";
    pub const snowy: []const u8 = "snowy";
    pub const tip: []const u8 = "tip";
    pub const triggered: []const u8 = "triggered";
    pub const unstable: []const u8 = "unstable";
    pub const waterlogged: []const u8 = "waterlogged";
    pub const horizontal_axis: []const u8 = "axis";
    pub const axis: []const u8 = "axis";
    pub const up: []const u8 = "up";
    pub const down: []const u8 = "down";
    pub const north: []const u8 = "north";
    pub const east: []const u8 = "east";
    pub const south: []const u8 = "south";
    pub const west: []const u8 = "west";
    pub const facing: []const u8 = "facing";
    pub const facing_hopper: []const u8 = "facing";
    pub const horizontal_facing: []const u8 = "facing";
    pub const flower_amount: []const u8 = "flower_amount";
    pub const segment_amount: []const u8 = "segment_amount";
    pub const orientation: []const u8 = "orientation";
    pub const attach_face: []const u8 = "face";
    pub const bell_attachment: []const u8 = "attachment";
    pub const east_wall: []const u8 = "east";
    pub const north_wall: []const u8 = "north";
    pub const south_wall: []const u8 = "south";
    pub const west_wall: []const u8 = "west";
    pub const east_redstone: []const u8 = "east";
    pub const north_redstone: []const u8 = "north";
    pub const south_redstone: []const u8 = "south";
    pub const west_redstone: []const u8 = "west";
    pub const double_block_half: []const u8 = "half";
    pub const half: []const u8 = "half";
    pub const side_chain_part: []const u8 = "side_chain";
    pub const rail_shape: []const u8 = "shape";
    pub const rail_shape_straight: []const u8 = "shape";
    pub const age_1: []const u8 = "age";
    pub const age_2: []const u8 = "age";
    pub const age_3: []const u8 = "age";
    pub const age_4: []const u8 = "age";
    pub const age_5: []const u8 = "age";
    pub const age_7: []const u8 = "age";
    pub const age_15: []const u8 = "age";
    pub const age_25: []const u8 = "age";
    pub const bites: []const u8 = "bites";
    pub const candles: []const u8 = "candles";
    pub const delay: []const u8 = "delay";
    pub const distance: []const u8 = "distance";
    pub const eggs: []const u8 = "eggs";
    pub const hatch: []const u8 = "hatch";
    pub const layers: []const u8 = "layers";
    pub const level_cauldron: []const u8 = "level";
    pub const level_composter: []const u8 = "level";
    pub const level_flowing: []const u8 = "level";
    pub const level_honey: []const u8 = "honey_level";
    pub const level: []const u8 = "level";
    pub const moisture: []const u8 = "moisture";
    pub const note: []const u8 = "note";
    pub const pickles: []const u8 = "pickles";
    pub const power: []const u8 = "power";
    pub const stage: []const u8 = "stage";
    pub const stability_distance: []const u8 = "distance";
    pub const respawn_anchor_charges: []const u8 = "charges";
    pub const dried_ghast_hydration_levels: []const u8 = "hydration";
    pub const rotation_16: []const u8 = "rotation";
    pub const bed_part: []const u8 = "part";
    pub const chest_type: []const u8 = "type";
    pub const mode_comparator: []const u8 = "mode";
    pub const door_hinge: []const u8 = "hinge";
    pub const noteblock_instrument: []const u8 = "instrument";
    pub const piston_type: []const u8 = "type";
    pub const slab_type: []const u8 = "type";
    pub const stairs_shape: []const u8 = "shape";
    pub const structureblock_mode: []const u8 = "mode";
    pub const bamboo_leaves: []const u8 = "leaves";
    pub const tilt: []const u8 = "tilt";
    pub const vertical_direction: []const u8 = "vertical_direction";
    pub const speleothem_thickness: []const u8 = "thickness";
    pub const sculk_sensor_phase: []const u8 = "sculk_sensor_phase";
    pub const slot_0_occupied: []const u8 = "slot_0_occupied";
    pub const slot_1_occupied: []const u8 = "slot_1_occupied";
    pub const slot_2_occupied: []const u8 = "slot_2_occupied";
    pub const slot_3_occupied: []const u8 = "slot_3_occupied";
    pub const slot_4_occupied: []const u8 = "slot_4_occupied";
    pub const slot_5_occupied: []const u8 = "slot_5_occupied";
    pub const dusted: []const u8 = "dusted";
    pub const cracked: []const u8 = "cracked";
    pub const crafting: []const u8 = "crafting";
    pub const trial_spawner_state: []const u8 = "trial_spawner_state";
    pub const vault_state: []const u8 = "vault_state";
    pub const creaking_heart_state: []const u8 = "creaking_heart_state";
    pub const ominous: []const u8 = "ominous";
    pub const test_block_mode: []const u8 = "mode";
    pub const map: []const u8 = "map";
    pub const copper_golem_pose: []const u8 = "copper_golem_pose";
    pub const potent_sulfur_state: []const u8 = "potent_sulfur_state";
};

pub const FluidStrings = struct {
    pub const empty: []const u8 = "empty";
    pub const flowing_water: []const u8 = "flowing_water";
    pub const water: []const u8 = "water";
    pub const flowing_lava: []const u8 = "flowing_lava";
    pub const lava: []const u8 = "lava";
};

pub const FluidPropertyStrings = struct {
    pub const falling: []const u8 = "falling";
    pub const level: []const u8 = "level";
};

pub const FrontAndTopStrings = struct {
    pub const down_east: []const u8 = "down_east";
    pub const down_north: []const u8 = "down_north";
    pub const down_south: []const u8 = "down_south";
    pub const down_west: []const u8 = "down_west";
    pub const up_east: []const u8 = "up_east";
    pub const up_north: []const u8 = "up_north";
    pub const up_south: []const u8 = "up_south";
    pub const up_west: []const u8 = "up_west";
    pub const west_up: []const u8 = "west_up";
    pub const east_up: []const u8 = "east_up";
    pub const north_up: []const u8 = "north_up";
    pub const south_up: []const u8 = "south_up";
};

pub const StructureSpawnBoundingBoxTypeStrings = struct {
    pub const piece: []const u8 = "piece";
    pub const structure: []const u8 = "full";
};

pub const TerrainAdjustmentStrings = struct {
    pub const none: []const u8 = "none";
    pub const bury: []const u8 = "bury";
    pub const beard_thin: []const u8 = "beard_thin";
    pub const beard_box: []const u8 = "beard_box";
    pub const encapsulate: []const u8 = "encapsulate";
};

pub const RandomSpreadTypeStrings = struct {
    pub const linear: []const u8 = "linear";
    pub const triangular: []const u8 = "triangular";
};

pub const StructureFrequencyReductionMethodStrings = struct {
    pub const default: []const u8 = "default";
    pub const legacy_type_1: []const u8 = "legacy_type_1";
    pub const legacy_type_2: []const u8 = "legacy_type_2";
    pub const legacy_type_3: []const u8 = "legacy_type_3";
};

pub const StructurePoolProjectionStrings = struct {
    pub const terrain_matching: []const u8 = "terrain_matching";
    pub const rigid: []const u8 = "rigid";
};

pub const MineshaftTypeStrings = struct {
    pub const normal: []const u8 = "normal";
    pub const mesa: []const u8 = "mesa";
};

pub const OceanRuinTypeStrings = struct {
    pub const warm: []const u8 = "warm";
    pub const cold: []const u8 = "cold";
};

pub const RuinedPortalVerticalPlacementStrings = struct {
    pub const on_land_surface: []const u8 = "on_land_surface";
    pub const partly_buried: []const u8 = "partly_buried";
    pub const on_ocean_floor: []const u8 = "on_ocean_floor";
    pub const in_mountain: []const u8 = "in_mountain";
    pub const underground: []const u8 = "underground";
    pub const in_nether: []const u8 = "in_nether";
};

pub const LiquidSettingsStrings = struct {
    pub const ignore_waterlogging: []const u8 = "ignore_waterlogging";
    pub const apply_waterlogging: []const u8 = "apply_waterlogging";
};

pub const AttachFaceStrings = struct {
    pub const floor: []const u8 = "floor";
    pub const wall: []const u8 = "wall";
    pub const ceiling: []const u8 = "ceiling";
};

pub const HalfStrings = struct {
    pub const top: []const u8 = "top";
    pub const bottom: []const u8 = "bottom";
};

pub const RailShapeStrings = struct {
    pub const north_south: []const u8 = "north_south";
    pub const east_west: []const u8 = "east_west";
    pub const ascending_east: []const u8 = "ascending_east";
    pub const ascending_west: []const u8 = "ascending_west";
    pub const ascending_north: []const u8 = "ascending_north";
    pub const ascending_south: []const u8 = "ascending_south";
    pub const south_east: []const u8 = "south_east";
    pub const south_west: []const u8 = "south_west";
    pub const north_west: []const u8 = "north_west";
    pub const north_east: []const u8 = "north_east";
};

pub const RedstoneSideStrings = struct {
    pub const up: []const u8 = "up";
    pub const side: []const u8 = "side";
    pub const none: []const u8 = "none";
};

pub const SlabTypeStrings = struct {
    pub const top: []const u8 = "top";
    pub const bottom: []const u8 = "bottom";
    pub const double: []const u8 = "double";
};

pub const StairsShapeStrings = struct {
    pub const straight: []const u8 = "straight";
    pub const inner_left: []const u8 = "inner_left";
    pub const inner_right: []const u8 = "inner_right";
    pub const outer_left: []const u8 = "outer_left";
    pub const outer_right: []const u8 = "outer_right";
};

pub const StructureModeStrings = struct {
    pub const save: []const u8 = "save";
    pub const load: []const u8 = "load";
    pub const corner: []const u8 = "corner";
    pub const data: []const u8 = "data";
};

pub const RuleTestTypeStrings = struct {
    pub const always_true: []const u8 = "always_true";
    pub const block_match: []const u8 = "block_match";
    pub const block_state_match: []const u8 = "blockstate_match";
    pub const tag_match: []const u8 = "tag_match";
    pub const random_block_match: []const u8 = "random_block_match";
    pub const random_block_state_match: []const u8 = "random_blockstate_match";
};

pub const PosRuleTestTypeStrings = struct {
    pub const always_true: []const u8 = "always_true";
    pub const linear: []const u8 = "linear_pos";
    pub const axis_aligned_linear: []const u8 = "axis_aligned_linear_pos";
};

pub const BlockPredicateTypeStrings = struct {
    pub const matching_blocks: []const u8 = "matching_blocks";
    pub const matching_block_tag: []const u8 = "matching_block_tag";
    pub const matching_fluids: []const u8 = "matching_fluids";
    pub const matching_biomes: []const u8 = "matching_biomes";
    pub const has_sturdy_face: []const u8 = "has_sturdy_face";
    pub const solid: []const u8 = "solid";
    pub const replaceable: []const u8 = "replaceable";
    pub const would_survive: []const u8 = "would_survive";
    pub const inside_world_bounds: []const u8 = "inside_world_bounds";
    pub const any_of: []const u8 = "any_of";
    pub const all_of: []const u8 = "all_of";
    pub const not: []const u8 = "not";
    pub const true_value: []const u8 = "true";
    pub const unobstructed: []const u8 = "unobstructed";
};

pub const BlockStateProviderTypeStrings = struct {
    pub const simple: []const u8 = "simple_state_provider";
    pub const weighted: []const u8 = "weighted_state_provider";
    pub const noise_threshold: []const u8 = "noise_threshold_provider";
    pub const noise: []const u8 = "noise_provider";
    pub const dual_noise: []const u8 = "dual_noise_provider";
    pub const rotated_block: []const u8 = "rotated_block_provider";
    pub const randomized_int: []const u8 = "randomized_int_state_provider";
    pub const rule_based: []const u8 = "rule_based_state_provider";
};

pub const PlacementModifierTypeStrings = struct {
    pub const block_predicate_filter: []const u8 = "block_predicate_filter";
    pub const rarity_filter: []const u8 = "rarity_filter";
    pub const surface_relative_threshold: []const u8 = "surface_relative_threshold_filter";
    pub const surface_water_depth: []const u8 = "surface_water_depth_filter";
    pub const biome_filter: []const u8 = "biome";
    pub const count: []const u8 = "count";
    pub const noise_based_count: []const u8 = "noise_based_count";
    pub const noise_threshold_count: []const u8 = "noise_threshold_count";
    pub const count_on_every_layer: []const u8 = "count_on_every_layer";
    pub const environment_scan: []const u8 = "environment_scan";
    pub const heightmap: []const u8 = "heightmap";
    pub const height_range: []const u8 = "height_range";
    pub const in_square: []const u8 = "in_square";
    pub const random_offset: []const u8 = "random_offset";
    pub const fixed: []const u8 = "fixed_placement";
};

pub const WorldCarverTypeStrings = struct {
    pub const cave: []const u8 = "cave";
    pub const nether_cave: []const u8 = "nether_cave";
    pub const canyon: []const u8 = "canyon";
};

pub const TrunkPlacerTypeStrings = struct {
    pub const straight: []const u8 = "straight_trunk_placer";
    pub const forking: []const u8 = "forking_trunk_placer";
    pub const giant: []const u8 = "giant_trunk_placer";
    pub const mega_jungle: []const u8 = "mega_jungle_trunk_placer";
    pub const dark_oak: []const u8 = "dark_oak_trunk_placer";
    pub const fancy: []const u8 = "fancy_trunk_placer";
    pub const bending: []const u8 = "bending_trunk_placer";
    pub const upwards_branching: []const u8 = "upwards_branching_trunk_placer";
    pub const cherry: []const u8 = "cherry_trunk_placer";
};

pub const FoliagePlacerTypeStrings = struct {
    pub const blob: []const u8 = "blob_foliage_placer";
    pub const spruce: []const u8 = "spruce_foliage_placer";
    pub const pine: []const u8 = "pine_foliage_placer";
    pub const acacia: []const u8 = "acacia_foliage_placer";
    pub const bush: []const u8 = "bush_foliage_placer";
    pub const fancy: []const u8 = "fancy_foliage_placer";

    // Mojang's registry id is "jungle_foliage_placer" even though the class is MegaJungleFoliagePlacer.
    pub const mega_jungle: []const u8 = "jungle_foliage_placer";

    pub const mega_pine: []const u8 = "mega_pine_foliage_placer";
    pub const dark_oak: []const u8 = "dark_oak_foliage_placer";
    pub const random_spread: []const u8 = "random_spread_foliage_placer";
    pub const cherry: []const u8 = "cherry_foliage_placer";
};

pub const RootPlacerTypeStrings = struct {
    pub const mangrove: []const u8 = "mangrove_root_placer";
};

pub const TreeDecoratorTypeStrings = struct {
    pub const trunk_vine: []const u8 = "trunk_vine";
    pub const leave_vine: []const u8 = "leave_vine";
    pub const pale_moss: []const u8 = "pale_moss";
    pub const creaking_heart: []const u8 = "creaking_heart";
    pub const cocoa: []const u8 = "cocoa";
    pub const beehive: []const u8 = "beehive";
    pub const alter_ground: []const u8 = "alter_ground";
    pub const attached_to_leaves: []const u8 = "attached_to_leaves";
    pub const place_on_ground: []const u8 = "place_on_ground";
    pub const attached_to_logs: []const u8 = "attached_to_logs";
};

pub const FeatureSizeTypeStrings = struct {
    pub const two_layers: []const u8 = "two_layers_feature_size";
    pub const three_layers: []const u8 = "three_layers_feature_size";
};

pub const SurfaceConditionTypeStrings = struct {
    pub const biome: []const u8 = "biome";
    pub const noise_threshold: []const u8 = "noise_threshold";
    pub const vertical_gradient: []const u8 = "vertical_gradient";
    pub const y_above: []const u8 = "y_above";
    pub const water: []const u8 = "water";
    pub const temperature: []const u8 = "temperature";
    pub const steep: []const u8 = "steep";
    pub const not: []const u8 = "not";
    pub const hole: []const u8 = "hole";
    pub const above_preliminary_surface: []const u8 = "above_preliminary_surface";
    pub const stone_depth: []const u8 = "stone_depth";
};

pub const SurfaceRuleTypeStrings = struct {
    pub const bandlands: []const u8 = "bandlands";
    pub const block: []const u8 = "block";
    pub const sequence: []const u8 = "sequence";
    pub const condition: []const u8 = "condition";
};

pub const DensityFunctionTypeStrings = struct {
    pub const blend_alpha: []const u8 = "blend_alpha";
    pub const blend_offset: []const u8 = "blend_offset";
    pub const beardifier: []const u8 = "beardifier";
    pub const old_blended_noise: []const u8 = "old_blended_noise";

    pub const interpolated: []const u8 = "interpolated";
    pub const flat_cache: []const u8 = "flat_cache";
    pub const cache_2d: []const u8 = "cache_2d";
    pub const cache_once: []const u8 = "cache_once";
    pub const cache_all_in_cell: []const u8 = "cache_all_in_cell";
    pub const blend_density: []const u8 = "blend_density";

    pub const noise: []const u8 = "noise";
    pub const end_islands: []const u8 = "end_islands";
    pub const shifted_noise: []const u8 = "shifted_noise";
    pub const range_choice: []const u8 = "range_choice";
    pub const interval_select: []const u8 = "interval_select";
    pub const shift_a: []const u8 = "shift_a";
    pub const shift_b: []const u8 = "shift_b";
    pub const shift: []const u8 = "shift";
    pub const clamp: []const u8 = "clamp";

    pub const abs: []const u8 = "abs";
    pub const square: []const u8 = "square";
    pub const cube: []const u8 = "cube";
    pub const half_negative: []const u8 = "half_negative";
    pub const quarter_negative: []const u8 = "quarter_negative";
    pub const invert: []const u8 = "invert";
    pub const squeeze: []const u8 = "squeeze";

    pub const add: []const u8 = "add";
    pub const mul: []const u8 = "mul";
    pub const min: []const u8 = "min";
    pub const max: []const u8 = "max";

    pub const spline: []const u8 = "spline";
    pub const constant: []const u8 = "constant";
    pub const y_clamped_gradient: []const u8 = "y_clamped_gradient";
    pub const find_top_surface: []const u8 = "find_top_surface";
};

pub const FeatureTypeStrings = struct {
    pub const no_op: []const u8 = "no_op";
    pub const tree: []const u8 = "tree";
    pub const fallen_tree: []const u8 = "fallen_tree";
    pub const block_pile: []const u8 = "block_pile";
    pub const spring: []const u8 = "spring_feature";
    pub const chorus_plant: []const u8 = "chorus_plant";
    pub const replace_single_block: []const u8 = "replace_single_block";
    pub const void_start_platform: []const u8 = "void_start_platform";
    pub const desert_well: []const u8 = "desert_well";
    pub const fossil: []const u8 = "fossil";
    pub const huge_red_mushroom: []const u8 = "huge_red_mushroom";
    pub const huge_brown_mushroom: []const u8 = "huge_brown_mushroom";
    pub const spike: []const u8 = "spike";
    pub const glowstone_blob: []const u8 = "glowstone_blob";
    pub const freeze_top_layer: []const u8 = "freeze_top_layer";
    pub const vines: []const u8 = "vines";
    pub const block_column: []const u8 = "block_column";
    pub const vegetation_patch: []const u8 = "vegetation_patch";
    pub const waterlogged_vegetation_patch: []const u8 = "waterlogged_vegetation_patch";
    pub const root_system: []const u8 = "root_system";
    pub const multiface_growth: []const u8 = "multiface_growth";
    pub const underwater_magma: []const u8 = "underwater_magma";
    pub const monster_room: []const u8 = "monster_room";
    pub const blue_ice: []const u8 = "blue_ice";
    pub const iceberg: []const u8 = "iceberg";
    pub const block_blob: []const u8 = "block_blob";
    pub const disk: []const u8 = "disk";
    pub const lake: []const u8 = "lake";
    pub const ore: []const u8 = "ore";
    pub const end_platform: []const u8 = "end_platform";
    pub const end_spike: []const u8 = "end_spike";
    pub const end_island: []const u8 = "end_island";
    pub const end_gateway: []const u8 = "end_gateway";
    pub const seagrass: []const u8 = "seagrass";
    pub const kelp: []const u8 = "kelp";
    pub const coral_tree: []const u8 = "coral_tree";
    pub const coral_mushroom: []const u8 = "coral_mushroom";
    pub const coral_claw: []const u8 = "coral_claw";
    pub const sea_pickle: []const u8 = "sea_pickle";
    pub const simple_block: []const u8 = "simple_block";
    pub const bamboo: []const u8 = "bamboo";
    pub const huge_fungus: []const u8 = "huge_fungus";
    pub const nether_forest_vegetation: []const u8 = "nether_forest_vegetation";
    pub const weeping_vines: []const u8 = "weeping_vines";
    pub const twisting_vines: []const u8 = "twisting_vines";
    pub const basalt_columns: []const u8 = "basalt_columns";
    pub const delta_feature: []const u8 = "delta_feature";

    // Java field/class name is replace blobs; registry id is netherrack_replace_blobs.
    pub const replace_blobs: []const u8 = "netherrack_replace_blobs";

    pub const fill_layer: []const u8 = "fill_layer";
    pub const bonus_chest: []const u8 = "bonus_chest";
    pub const basalt_pillar: []const u8 = "basalt_pillar";
    pub const scattered_ore: []const u8 = "scattered_ore";
    pub const random_selector: []const u8 = "random_selector";
    pub const weighted_random_selector: []const u8 = "weighted_random_selector";
    pub const simple_random_selector: []const u8 = "simple_random_selector";
    pub const random_boolean_selector: []const u8 = "random_boolean_selector";
    pub const sequence: []const u8 = "sequence";
    pub const template: []const u8 = "template";
    pub const geode: []const u8 = "geode";
    pub const speleothem_cluster: []const u8 = "speleothem_cluster";
    pub const large_dripstone: []const u8 = "large_dripstone";
    pub const speleothem: []const u8 = "speleothem";
    pub const sculk_patch: []const u8 = "sculk_patch";
};

pub const StructurePoolElementTypeStrings = struct {
    pub const single: []const u8 = "single_pool_element";
    pub const list: []const u8 = "list_pool_element";
    pub const feature: []const u8 = "feature_pool_element";
    pub const empty: []const u8 = "empty_pool_element";
    pub const legacy_single: []const u8 = "legacy_single_pool_element";
};

pub const PoolAliasBindingTypeStrings = struct {
    pub const random: []const u8 = "random";
    pub const random_group: []const u8 = "random_group";
    pub const direct: []const u8 = "direct";
};

pub const StructureProcessorTypeStrings = struct {
    pub const blackstone_replace: []const u8 = "blackstone_replace";
    pub const block_age: []const u8 = "block_age";
    pub const block_ignore: []const u8 = "block_ignore";
    pub const block_rot: []const u8 = "block_rot";
    pub const capped: []const u8 = "capped";
    pub const gravity: []const u8 = "gravity";
    pub const jigsaw_replacement: []const u8 = "jigsaw_replacement";
    pub const lava_submerged: []const u8 = "lava_submerged_block";
    pub const nop: []const u8 = "nop";
    pub const protected_blocks: []const u8 = "protected_blocks";
    pub const rule: []const u8 = "rule";
};

pub const RuleBlockEntityModifierTypeStrings = struct {
    pub const clear: []const u8 = "clear";
    pub const passthrough: []const u8 = "passthrough";
    pub const append_static: []const u8 = "append_static";
    pub const append_loot: []const u8 = "append_loot";
};
