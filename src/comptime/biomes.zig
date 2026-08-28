//! Immutable biome selection/generation/spawn configuration.

const strings = @import("strings.zig");
const core = @import("core.zig");
const blocks = @import("blocks.zig");
const features = @import("features.zig");

const BiomePathStrings = strings.BiomePathStrings;
const IdentifierStrings = strings.IdentifierStrings;

const BiomeTemperatureModifier = core.BiomeTemperatureModifier;
const MobCategory = core.MobCategory;
const RegistryIdentifierData = core.RegistryIdentifierData;
const ResourceKey = core.ResourceKey;
const WeightedList = core.WeightedList;

const HolderSetRef = blocks.HolderSetRef;

const ConfiguredWorldCarverData = features.ConfiguredWorldCarverData;
const PlacedFeatureData = features.PlacedFeatureData;

// =============================================================================
// Biome/climate constants
// =============================================================================

pub const biome_temperature_cache_size: i32 = 1_024;

pub const biome_manager_chunk_center_quart: i32 = 2;

pub const biome_manager_zoom_bits: i32 = 2;

pub const biome_manager_zoom: i32 = 4;

pub const biome_manager_zoom_mask: i32 = 3;

pub const climate_debug_slow_biome_search: bool = false;

pub const climate_quantization_factor: f32 = 10_000.0;

pub const climate_parameter_count: i32 = 7;

pub const climate_children_per_node: i32 = 6;

pub const climate_max_radius: i64 = 2_048;

pub const biome_valley_size: f32 = 0.05;

pub const biome_low_start: f32 = 0.26666668;

pub const biome_high_start: f32 = 0.4;

pub const biome_high_end: f32 = 0.93333334;

pub const biome_peak_size: f32 = 0.1;

pub const biome_peak_start: f32 = 0.56666666;

pub const biome_peak_end: f32 = 0.7666667;

pub const biome_near_inland_start: f32 = -0.11;

pub const biome_mid_inland_start: f32 = 0.03;

pub const biome_far_inland_start: f32 = 0.3;

pub const biome_erosion_index_1_start: f32 = -0.78;

pub const biome_erosion_index_2_start: f32 = -0.375;

pub const biome_erosion_deep_dark_dryness_threshold: f32 = -0.225;

pub const biome_depth_deep_dark_dryness_threshold: f32 = 0.9;

// -----------------------------------------------------------------------------
// Mth constants used by world-generation math
// -----------------------------------------------------------------------------

// =============================================================================
// Biome resource keys
// =============================================================================

pub const BiomeKeyData = struct {
    pub const the_void: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.the_void } };
    pub const plains: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.plains } };
    pub const sunflower_plains: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.sunflower_plains } };
    pub const snowy_plains: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.snowy_plains } };
    pub const ice_spikes: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.ice_spikes } };
    pub const desert: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.desert } };
    pub const swamp: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.swamp } };
    pub const mangrove_swamp: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.mangrove_swamp } };
    pub const forest: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.forest } };
    pub const flower_forest: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.flower_forest } };
    pub const birch_forest: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.birch_forest } };
    pub const dark_forest: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.dark_forest } };
    pub const pale_garden: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.pale_garden } };
    pub const old_growth_birch_forest: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.old_growth_birch_forest } };
    pub const old_growth_pine_taiga: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.old_growth_pine_taiga } };
    pub const old_growth_spruce_taiga: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.old_growth_spruce_taiga } };
    pub const taiga: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.taiga } };
    pub const snowy_taiga: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.snowy_taiga } };
    pub const savanna: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.savanna } };
    pub const savanna_plateau: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.savanna_plateau } };
    pub const windswept_hills: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.windswept_hills } };
    pub const windswept_gravelly_hills: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.windswept_gravelly_hills } };
    pub const windswept_forest: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.windswept_forest } };
    pub const windswept_savanna: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.windswept_savanna } };
    pub const jungle: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.jungle } };
    pub const sparse_jungle: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.sparse_jungle } };
    pub const bamboo_jungle: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.bamboo_jungle } };
    pub const badlands: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.badlands } };
    pub const eroded_badlands: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.eroded_badlands } };
    pub const wooded_badlands: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.wooded_badlands } };
    pub const meadow: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.meadow } };
    pub const cherry_grove: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.cherry_grove } };
    pub const grove: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.grove } };
    pub const snowy_slopes: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.snowy_slopes } };
    pub const frozen_peaks: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.frozen_peaks } };
    pub const jagged_peaks: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.jagged_peaks } };
    pub const stony_peaks: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.stony_peaks } };
    pub const river: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.river } };
    pub const frozen_river: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.frozen_river } };
    pub const beach: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.beach } };
    pub const snowy_beach: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.snowy_beach } };
    pub const stony_shore: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.stony_shore } };
    pub const warm_ocean: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.warm_ocean } };
    pub const lukewarm_ocean: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.lukewarm_ocean } };
    pub const deep_lukewarm_ocean: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.deep_lukewarm_ocean } };
    pub const ocean: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.ocean } };
    pub const deep_ocean: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.deep_ocean } };
    pub const cold_ocean: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.cold_ocean } };
    pub const deep_cold_ocean: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.deep_cold_ocean } };
    pub const frozen_ocean: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.frozen_ocean } };
    pub const deep_frozen_ocean: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.deep_frozen_ocean } };
    pub const mushroom_fields: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.mushroom_fields } };
    pub const dripstone_caves: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.dripstone_caves } };
    pub const lush_caves: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.lush_caves } };
    pub const deep_dark: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.deep_dark } };
    pub const sulfur_caves: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.sulfur_caves } };
    pub const nether_wastes: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.nether_wastes } };
    pub const warped_forest: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.warped_forest } };
    pub const crimson_forest: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.crimson_forest } };
    pub const soul_sand_valley: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.soul_sand_valley } };
    pub const basalt_deltas: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.basalt_deltas } };
    pub const the_end: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.the_end } };
    pub const end_highlands: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.end_highlands } };
    pub const end_midlands: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.end_midlands } };
    pub const small_end_islands: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.small_end_islands } };
    pub const end_barrens: ResourceKey = .{ .registry_name = RegistryIdentifierData.biome, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = BiomePathStrings.end_barrens } };
};

// =============================================================================
// Biome declarative types
// =============================================================================

pub const MobSpawnerData = struct {
    entity_type: ResourceKey,
    min_count: i32,
    max_count: i32,
};

pub const MobSpawnCostData = struct {
    energy_budget: f64,
    charge: f64,
};

pub const MobCategorySpawnerData = struct {
    category: MobCategory,
    spawns: WeightedList(MobSpawnerData),
};

pub const EntitySpawnCostEntryData = struct {
    entity_type: ResourceKey,
    cost: MobSpawnCostData,
};

pub const MobSpawnSettingsData = struct {
    creature_generation_probability: f32,
    spawners: []const MobCategorySpawnerData,
    mob_spawn_costs: []const EntitySpawnCostEntryData,
};

pub const BiomeGenerationSettingsData = struct {
    carvers: HolderSetRef(ConfiguredWorldCarverData),

    // Indexed in GenerationStep.Decoration ordinal order.
    features: []const HolderSetRef(PlacedFeatureData),
};

pub const BiomeClimateSettingsData = struct {
    has_precipitation: bool,
    temperature: f32,
    temperature_modifier: BiomeTemperatureModifier,
    downfall: f32,
};

// Generation-only projection of Java Biome.
// BiomeSpecialEffects and EnvironmentAttributeMap are non-generation presentation/environment data
// and should live in a separate subsystem if they are ever needed.

pub const BiomeWorldgenData = struct {
    climate: BiomeClimateSettingsData,
    generation: BiomeGenerationSettingsData,
    mob_settings: MobSpawnSettingsData,
};

// =============================================================================
// Biome constant data
// =============================================================================

pub const mob_spawn_settings_empty_spawns: WeightedList(MobSpawnerData) = .{
    .total_weight = 0,
    .items = &.{},
};

pub const biome_generation_settings_empty: BiomeGenerationSettingsData = .{
    .carvers = .{ .direct = &.{} },
    .features = &.{},
};
