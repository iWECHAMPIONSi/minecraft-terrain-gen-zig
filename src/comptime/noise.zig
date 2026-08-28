//! Immutable noise, density, aquifer, ore, surface, and blending configuration.
//! Sampling/evaluation remains runtime code.

const strings = @import("strings.zig");
const core = @import("core.zig");
const blocks = @import("blocks.zig");

const IdentifierStrings = strings.IdentifierStrings;
const NoisePathStrings = strings.NoisePathStrings;

const CaveSurface = core.CaveSurface;
const ChunkOffset = core.ChunkOffset;
const ClimateParameterPoint = core.ClimateParameterPoint;
const DensityMappedType = core.DensityMappedType;
const DensityMarkerType = core.DensityMarkerType;
const DensityMulOrAddType = core.DensityMulOrAddType;
const DensityTwoArgumentType = core.DensityTwoArgumentType;
const Identifier = core.Identifier;
const NoiseSettings = core.NoiseSettings;
const NormalNoiseParameters = core.NormalNoiseParameters;
const RegistryIdentifierData = core.RegistryIdentifierData;
const ResourceKey = core.ResourceKey;
const Vector3i32 = core.Vector3i32;
const VerticalAnchor = core.VerticalAnchor;

const BlockStateSpec = blocks.BlockStateSpec;
const RegistryHolderSet = blocks.RegistryHolderSet;

// =============================================================================
// Primitive terrain/noise constants
// =============================================================================

pub const improved_noise_shift_up_epsilon: f32 = 1.0e-7;

pub const perlin_noise_round_off: i32 = 33_554_432;

pub const simplex_noise_sqrt_3: f64 = 1.7320508075688772;

pub const simplex_noise_f2: f64 = 0.3660254037844386;

pub const simplex_noise_g2: f64 = 0.21132486540518713;

// F3/G3 are method-local fixed values in SimplexNoise rather than static finals.

pub const simplex_noise_f3: f64 = 0.3333333333333333;

pub const simplex_noise_g3: f64 = 0.16666666666666666;

pub const normal_noise_input_factor: f64 = 1.0181268882175227;

pub const normal_noise_target_deviation: f64 = 0.3333333333333333;

// -----------------------------------------------------------------------------
// Density and density-router constants
// -----------------------------------------------------------------------------

pub const density_surface: f64 = 0.0;

pub const density_unrecoverably_dense: f64 = 64.0;

pub const density_unrecoverably_thin: f64 = -64.0;

pub const density_functions_max_reasonable_noise_value: f64 = 1_000_000.0;

pub const density_functions_island_threshold: f32 = -0.9;

pub const noise_router_global_offset: f32 = -0.50375;

pub const noise_router_ore_thickness: f32 = 0.08;

pub const noise_router_veininess_frequency: f64 = 1.5;

pub const noise_router_noodle_spacing_and_straightness: f64 = 1.5;

pub const noise_router_surface_density_threshold: f64 = 1.5625;

pub const noise_router_cheese_noise_target: f64 = -0.703125;

pub const noise_router_noise_zero: f64 = 0.390625;

pub const noise_router_island_chunk_distance: i32 = 64;

pub const noise_router_island_chunk_distance_sqr: i64 = 4_096;

pub const noise_router_density_y_anchor_bottom: i32 = -64;

pub const noise_router_density_y_anchor_top: i32 = 320;

pub const noise_router_density_y_bottom: f64 = 1.5;

pub const noise_router_density_y_top: f64 = -1.5;

pub const noise_router_overworld_bottom_slide_height: i32 = 24;

pub const noise_router_base_density_multiplier: f64 = 4.0;

// -----------------------------------------------------------------------------
// Terrain spline boundary constants
// -----------------------------------------------------------------------------

pub const terrain_deep_ocean_continentalness: f32 = -0.51;

pub const terrain_ocean_continentalness: f32 = -0.4;

pub const terrain_plains_continentalness: f32 = 0.1;

pub const terrain_beach_continentalness: f32 = -0.15;

// -----------------------------------------------------------------------------
// Aquifer constants
// -----------------------------------------------------------------------------

pub const aquifer_x_range: i32 = 10;

pub const aquifer_y_range: i32 = 9;

pub const aquifer_z_range: i32 = 10;

pub const aquifer_x_separation: i32 = 6;

pub const aquifer_y_separation: i32 = 3;

pub const aquifer_z_separation: i32 = 6;

pub const aquifer_x_spacing: i32 = 16;

pub const aquifer_y_spacing: i32 = 12;

pub const aquifer_z_spacing: i32 = 16;

pub const aquifer_x_spacing_shift: i32 = 4;

pub const aquifer_z_spacing_shift: i32 = 4;

pub const aquifer_max_reasonable_distance_to_center: i32 = 11;

pub const aquifer_flowing_update_simularity: f64 = -0.76;

pub const aquifer_sample_offset_x: i32 = -5;

pub const aquifer_sample_offset_y: i32 = 1;

pub const aquifer_sample_offset_z: i32 = -5;

pub const aquifer_min_cell_sample_x: i32 = 0;

pub const aquifer_min_cell_sample_y: i32 = -1;

pub const aquifer_min_cell_sample_z: i32 = 0;

pub const aquifer_max_cell_sample_x: i32 = 1;

pub const aquifer_max_cell_sample_y: i32 = 1;

pub const aquifer_max_cell_sample_z: i32 = 1;

// -----------------------------------------------------------------------------
// Ore-vein constants
// -----------------------------------------------------------------------------

pub const ore_veininess_threshold: f32 = 0.4;

pub const ore_edge_roundoff_begin: i32 = 20;

pub const ore_max_edge_roundoff: f64 = 0.2;

pub const ore_vein_solidness: f32 = 0.7;

pub const ore_min_richness: f32 = 0.1;

pub const ore_max_richness: f32 = 0.3;

pub const ore_max_richness_threshold: f32 = 0.6;

pub const ore_chance_of_raw_ore_block: f32 = 0.02;

pub const ore_skip_if_gap_noise_below: f32 = -0.3;

// -----------------------------------------------------------------------------
// Surface and structure-terrain-adaptation constants
// -----------------------------------------------------------------------------

pub const surface_how_far_below_preliminary_surface_to_build: i32 = 8;

pub const surface_cell_bits: i32 = 4;

pub const surface_cell_size: i32 = 16;

pub const surface_cell_mask: i32 = 15;

pub const beard_kernel_radius: i32 = 12;

pub const beard_kernel_size: i32 = 24;

// -----------------------------------------------------------------------------
// Ordinary feature constants
// -----------------------------------------------------------------------------

pub const blending_density_factor: f64 = 0.1;

pub const blending_cell_width: i32 = 4;

pub const blending_cell_height: i32 = 8;

pub const blending_cell_ratio: i32 = 2;

pub const blending_solid_density: f64 = 1.0;

pub const blending_air_density: f64 = -1.0;

pub const blending_cells_per_section_y: i32 = 2;

pub const blending_quarts_per_section: i32 = 4;

pub const blending_cell_horizontal_max_index_inside: i32 = 3;

pub const blending_cell_horizontal_max_index_outside: i32 = 4;

pub const blending_cell_column_inside_count: i32 = 7;

pub const blending_cell_column_outside_count: i32 = 9;

pub const blending_cell_column_count: i32 = 16;

pub const blending_no_value: f64 = 0x1.fffffffffffffp+1023;

pub const blender_height_blending_range_cells: i32 = 27;

pub const blender_height_blending_range_chunks: i32 = 7;

pub const blender_density_blending_range_cells: i32 = 2;

pub const blender_density_blending_range_chunks: i32 = 1;

pub const blender_old_chunk_xz_radius: f64 = 8.0;

// =============================================================================
// Noise keys, settings, parameters, and fixed tables
// =============================================================================

pub const NoiseSettingsData = struct {
    pub const overworld: NoiseSettings = .{ .min_y = -64, .height = 384, .noise_size_horizontal = 1, .noise_size_vertical = 2 };
    pub const nether: NoiseSettings = .{ .min_y = 0, .height = 128, .noise_size_horizontal = 1, .noise_size_vertical = 2 };
    pub const end: NoiseSettings = .{ .min_y = 0, .height = 128, .noise_size_horizontal = 2, .noise_size_vertical = 1 };
    pub const caves: NoiseSettings = .{ .min_y = -64, .height = 192, .noise_size_horizontal = 1, .noise_size_vertical = 2 };
    pub const floating_islands: NoiseSettings = .{ .min_y = 0, .height = 256, .noise_size_horizontal = 2, .noise_size_vertical = 1 };
};

pub const NoiseKeyData = struct {
    pub const temperature: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.temperature } };
    pub const vegetation: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.vegetation } };
    pub const continentalness: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.continentalness } };
    pub const erosion: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.erosion } };
    pub const temperature_large: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.temperature_large } };
    pub const vegetation_large: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.vegetation_large } };
    pub const continentalness_large: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.continentalness_large } };
    pub const erosion_large: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.erosion_large } };
    pub const ridge: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.ridge } };
    pub const shift: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.shift } };
    pub const temperature_nether: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.temperature_nether } };
    pub const vegetation_nether: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.vegetation_nether } };
    pub const aquifer_barrier: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.aquifer_barrier } };
    pub const aquifer_fluid_level_floodedness: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.aquifer_fluid_level_floodedness } };
    pub const aquifer_lava: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.aquifer_lava } };
    pub const aquifer_fluid_level_spread: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.aquifer_fluid_level_spread } };
    pub const pillar: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.pillar } };
    pub const pillar_rareness: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.pillar_rareness } };
    pub const pillar_thickness: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.pillar_thickness } };
    pub const spaghetti_2d: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.spaghetti_2d } };
    pub const spaghetti_2d_elevation: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.spaghetti_2d_elevation } };
    pub const spaghetti_2d_modulator: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.spaghetti_2d_modulator } };
    pub const spaghetti_2d_thickness: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.spaghetti_2d_thickness } };
    pub const spaghetti_3d_1: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.spaghetti_3d_1 } };
    pub const spaghetti_3d_2: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.spaghetti_3d_2 } };
    pub const spaghetti_3d_rarity: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.spaghetti_3d_rarity } };
    pub const spaghetti_3d_thickness: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.spaghetti_3d_thickness } };
    pub const spaghetti_roughness: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.spaghetti_roughness } };
    pub const spaghetti_roughness_modulator: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.spaghetti_roughness_modulator } };
    pub const cave_entrance: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.cave_entrance } };
    pub const cave_layer: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.cave_layer } };
    pub const cave_cheese: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.cave_cheese } };
    pub const ore_veininess: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.ore_veininess } };
    pub const ore_vein_a: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.ore_vein_a } };
    pub const ore_vein_b: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.ore_vein_b } };
    pub const ore_gap: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.ore_gap } };
    pub const noodle: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.noodle } };
    pub const noodle_thickness: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.noodle_thickness } };
    pub const noodle_ridge_a: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.noodle_ridge_a } };
    pub const noodle_ridge_b: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.noodle_ridge_b } };
    pub const jagged: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.jagged } };
    pub const surface: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.surface } };
    pub const surface_secondary: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.surface_secondary } };
    pub const clay_bands_offset: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.clay_bands_offset } };
    pub const badlands_pillar: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.badlands_pillar } };
    pub const badlands_pillar_roof: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.badlands_pillar_roof } };
    pub const badlands_surface: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.badlands_surface } };
    pub const iceberg_pillar: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.iceberg_pillar } };
    pub const iceberg_pillar_roof: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.iceberg_pillar_roof } };
    pub const iceberg_surface: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.iceberg_surface } };
    pub const sulfur_cave_gradient: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.sulfur_cave_gradient } };
    pub const swamp: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.swamp } };
    pub const calcite: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.calcite } };
    pub const gravel: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.gravel } };
    pub const powder_snow: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.powder_snow } };
    pub const packed_ice: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.packed_ice } };
    pub const ice: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.ice } };
    pub const soul_sand_layer: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.soul_sand_layer } };
    pub const gravel_layer: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.gravel_layer } };
    pub const patch: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.patch } };
    pub const netherrack: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.netherrack } };
    pub const nether_wart: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.nether_wart } };
    pub const nether_state_selector: ResourceKey = .{ .registry_name = RegistryIdentifierData.noise, .identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = NoisePathStrings.nether_state_selector } };
};

pub const NoiseParametersData = struct {
    pub const temperature: NormalNoiseParameters = .{ .first_octave = -10, .amplitudes = &.{ 1.5, 0.0, 1.0, 0.0, 0.0, 0.0 } };
    pub const vegetation: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{ 1.0, 1.0, 0.0, 0.0, 0.0, 0.0 } };
    pub const continentalness: NormalNoiseParameters = .{ .first_octave = -9, .amplitudes = &.{ 1.0, 1.0, 2.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0 } };
    pub const erosion: NormalNoiseParameters = .{ .first_octave = -9, .amplitudes = &.{ 1.0, 1.0, 0.0, 1.0, 1.0 } };
    pub const temperature_large: NormalNoiseParameters = .{ .first_octave = -12, .amplitudes = &.{ 1.5, 0.0, 1.0, 0.0, 0.0, 0.0 } };
    pub const vegetation_large: NormalNoiseParameters = .{ .first_octave = -10, .amplitudes = &.{ 1.0, 1.0, 0.0, 0.0, 0.0, 0.0 } };
    pub const continentalness_large: NormalNoiseParameters = .{ .first_octave = -11, .amplitudes = &.{ 1.0, 1.0, 2.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0 } };
    pub const erosion_large: NormalNoiseParameters = .{ .first_octave = -11, .amplitudes = &.{ 1.0, 1.0, 0.0, 1.0, 1.0 } };
    pub const ridge: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{ 1.0, 2.0, 1.0, 0.0, 0.0, 0.0 } };
    pub const shift: NormalNoiseParameters = .{ .first_octave = -3, .amplitudes = &.{ 1.0, 1.0, 1.0, 0.0 } };
    pub const temperature_nether: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{ 1.0, 1.0 } };
    pub const vegetation_nether: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{ 1.0, 1.0 } };
    pub const aquifer_barrier: NormalNoiseParameters = .{ .first_octave = -3, .amplitudes = &.{1.0} };
    pub const aquifer_fluid_level_floodedness: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{1.0} };
    pub const aquifer_lava: NormalNoiseParameters = .{ .first_octave = -1, .amplitudes = &.{1.0} };
    pub const aquifer_fluid_level_spread: NormalNoiseParameters = .{ .first_octave = -5, .amplitudes = &.{1.0} };
    pub const pillar: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{ 1.0, 1.0 } };
    pub const pillar_rareness: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const pillar_thickness: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const spaghetti_2d: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{1.0} };
    pub const spaghetti_2d_elevation: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const spaghetti_2d_modulator: NormalNoiseParameters = .{ .first_octave = -11, .amplitudes = &.{1.0} };
    pub const spaghetti_2d_thickness: NormalNoiseParameters = .{ .first_octave = -11, .amplitudes = &.{1.0} };
    pub const spaghetti_3d_1: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{1.0} };
    pub const spaghetti_3d_2: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{1.0} };
    pub const spaghetti_3d_rarity: NormalNoiseParameters = .{ .first_octave = -11, .amplitudes = &.{1.0} };
    pub const spaghetti_3d_thickness: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const spaghetti_roughness: NormalNoiseParameters = .{ .first_octave = -5, .amplitudes = &.{1.0} };
    pub const spaghetti_roughness_modulator: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const cave_entrance: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{ 0.4, 0.5, 1.0 } };
    pub const cave_layer: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const cave_cheese: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{ 0.5, 1.0, 2.0, 1.0, 2.0, 1.0, 0.0, 2.0, 0.0 } };
    pub const ore_veininess: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const ore_vein_a: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{1.0} };
    pub const ore_vein_b: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{1.0} };
    pub const ore_gap: NormalNoiseParameters = .{ .first_octave = -5, .amplitudes = &.{1.0} };
    pub const noodle: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const noodle_thickness: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const noodle_ridge_a: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{1.0} };
    pub const noodle_ridge_b: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{1.0} };
    pub const jagged: NormalNoiseParameters = .{ .first_octave = -16, .amplitudes = &.{ 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 } };
    pub const surface: NormalNoiseParameters = .{ .first_octave = -6, .amplitudes = &.{ 1.0, 1.0, 1.0 } };
    pub const surface_secondary: NormalNoiseParameters = .{ .first_octave = -6, .amplitudes = &.{ 1.0, 1.0, 0.0, 1.0 } };
    pub const clay_bands_offset: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const badlands_pillar: NormalNoiseParameters = .{ .first_octave = -2, .amplitudes = &.{ 1.0, 1.0, 1.0, 1.0 } };
    pub const badlands_pillar_roof: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{1.0} };
    pub const badlands_surface: NormalNoiseParameters = .{ .first_octave = -6, .amplitudes = &.{ 1.0, 1.0, 1.0 } };
    pub const iceberg_pillar: NormalNoiseParameters = .{ .first_octave = -6, .amplitudes = &.{ 1.0, 1.0, 1.0, 1.0 } };
    pub const iceberg_pillar_roof: NormalNoiseParameters = .{ .first_octave = -3, .amplitudes = &.{1.0} };
    pub const iceberg_surface: NormalNoiseParameters = .{ .first_octave = -6, .amplitudes = &.{ 1.0, 1.0, 1.0 } };
    pub const sulfur_cave_gradient: NormalNoiseParameters = .{ .first_octave = -5, .amplitudes = &.{ 1.0, 0.0, 1.0 } };
    pub const swamp: NormalNoiseParameters = .{ .first_octave = -2, .amplitudes = &.{1.0} };
    pub const calcite: NormalNoiseParameters = .{ .first_octave = -9, .amplitudes = &.{ 1.0, 1.0, 1.0, 1.0 } };
    pub const gravel: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{ 1.0, 1.0, 1.0, 1.0 } };
    pub const powder_snow: NormalNoiseParameters = .{ .first_octave = -6, .amplitudes = &.{ 1.0, 1.0, 1.0, 1.0 } };
    pub const packed_ice: NormalNoiseParameters = .{ .first_octave = -7, .amplitudes = &.{ 1.0, 1.0, 1.0, 1.0 } };
    pub const ice: NormalNoiseParameters = .{ .first_octave = -4, .amplitudes = &.{ 1.0, 1.0, 1.0, 1.0 } };
    pub const soul_sand_layer: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{ 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.013333333333333334 } };
    pub const gravel_layer: NormalNoiseParameters = .{ .first_octave = -8, .amplitudes = &.{ 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.013333333333333334 } };
    pub const patch: NormalNoiseParameters = .{ .first_octave = -5, .amplitudes = &.{ 1.0, 0.0, 0.0, 0.0, 0.0, 0.013333333333333334 } };
    pub const netherrack: NormalNoiseParameters = .{ .first_octave = -3, .amplitudes = &.{ 1.0, 0.0, 0.0, 0.35 } };
    pub const nether_wart: NormalNoiseParameters = .{ .first_octave = -3, .amplitudes = &.{ 1.0, 0.0, 0.0, 0.9 } };
    pub const nether_state_selector: NormalNoiseParameters = .{ .first_octave = -4, .amplitudes = &.{1.0} };
};

pub const simplex_noise_gradient: [16]Vector3i32 = .{
    .{ .x = 1, .y = 1, .z = 0 },
    .{ .x = -1, .y = 1, .z = 0 },
    .{ .x = 1, .y = -1, .z = 0 },
    .{ .x = -1, .y = -1, .z = 0 },
    .{ .x = 1, .y = 0, .z = 1 },
    .{ .x = -1, .y = 0, .z = 1 },
    .{ .x = 1, .y = 0, .z = -1 },
    .{ .x = -1, .y = 0, .z = -1 },
    .{ .x = 0, .y = 1, .z = 1 },
    .{ .x = 0, .y = -1, .z = 1 },
    .{ .x = 0, .y = 1, .z = -1 },
    .{ .x = 0, .y = -1, .z = -1 },
    .{ .x = 1, .y = 1, .z = 0 },
    .{ .x = 0, .y = -1, .z = 1 },
    .{ .x = -1, .y = 1, .z = 0 },
    .{ .x = 0, .y = -1, .z = -1 },
};

pub const aquifer_surface_sampling_offsets_in_chunks: [13]ChunkOffset = .{
    .{ .x = 0, .z = 0 },
    .{ .x = -2, .z = -1 },
    .{ .x = -1, .z = -1 },
    .{ .x = 0, .z = -1 },
    .{ .x = 1, .z = -1 },
    .{ .x = -3, .z = 0 },
    .{ .x = -2, .z = 0 },
    .{ .x = -1, .z = 0 },
    .{ .x = 1, .z = 0 },
    .{ .x = -2, .z = 1 },
    .{ .x = -1, .z = 1 },
    .{ .x = 0, .z = 1 },
    .{ .x = 1, .z = 1 },
};

// =============================================================================
// Density and surface declarative types
// =============================================================================

pub const NoiseParametersRef = union(enum) {
    reference: ResourceKey,
    direct: *const NormalNoiseParameters,
};

pub const DensityFunctionRef = union(enum) {
    reference: ResourceKey,
    direct: *const DensityFunctionData,
};

pub const OldBlendedNoiseData = struct {
    xz_scale: f64,
    y_scale: f64,
    xz_factor: f64,
    y_factor: f64,
    smear_scale_multiplier: f64,
};

pub const DensityNoiseData = struct {
    noise: NoiseParametersRef,
    xz_scale: f64,
    y_scale: f64,
};

pub const DensityShiftedNoiseData = struct {
    shift_x: *const DensityFunctionData,
    shift_y: *const DensityFunctionData,
    shift_z: *const DensityFunctionData,
    xz_scale: f64,
    y_scale: f64,
    noise: NoiseParametersRef,
};

pub const DensityRangeChoiceData = struct {
    input: *const DensityFunctionData,
    min_inclusive: f64,
    max_exclusive: f64,
    when_in_range: *const DensityFunctionData,
    when_out_of_range: *const DensityFunctionData,
};

pub const DensityIntervalSelectData = struct {
    input: *const DensityFunctionData,
    thresholds: []const f64,
    functions: []const *const DensityFunctionData,
};

pub const DensityClampData = struct {
    input: *const DensityFunctionData,
    min_value: f64,
    max_value: f64,
};

pub const DensityMappedData = struct {
    mapping: DensityMappedType,
    input: *const DensityFunctionData,
};

pub const DensityMulOrAddData = struct {
    operation: DensityMulOrAddType,
    input: *const DensityFunctionData,
    argument: f64,
};

pub const DensityTwoArgumentData = struct {
    operation: DensityTwoArgumentType,
    argument_1: *const DensityFunctionData,
    argument_2: *const DensityFunctionData,
};

pub const DensityMarkerData = struct {
    marker: DensityMarkerType,
    wrapped: *const DensityFunctionData,
};

pub const DensityYClampedGradientData = struct {
    from_y: i32,
    to_y: i32,
    from_value: f64,
    to_value: f64,
};

pub const DensityFindTopSurfaceData = struct {
    density: *const DensityFunctionData,
    upper_bound: *const DensityFunctionData,
    lower_bound: i32,
    cell_height: i32,
};

// CubicSpline's Java Multipoint minValue/maxValue fields are constructor-derived.
// The declarative form keeps only source-defining coordinate/points/derivatives.

pub const DensitySplineCoordinate = struct {
    function: *const DensityFunctionData,
};

pub const DensitySplinePoint = struct {
    location: f32,
    value: *const DensitySplineData,
    derivative: f32,
};

pub const DensitySplineMultipointData = struct {
    coordinate: DensitySplineCoordinate,
    points: []const DensitySplinePoint,
};

pub const DensitySplineData = union(enum) {
    constant: f32,
    multipoint: DensitySplineMultipointData,
};

// End-islands is represented only as a source/configuration marker; its stored SimplexNoise is runtime.

pub const DensityFunctionData = union(enum) {
    blend_alpha,
    blend_offset,
    beardifier_marker,
    old_blended_noise: OldBlendedNoiseData,

    // Source/configuration marker. The seed-specific SimplexNoise stored by Java is runtime.
    end_islands,

    holder: DensityFunctionRef,
    marker: DensityMarkerData,
    noise: DensityNoiseData,
    shifted_noise: DensityShiftedNoiseData,
    range_choice: DensityRangeChoiceData,
    interval_select: DensityIntervalSelectData,

    shift_a: NoiseParametersRef,
    shift_b: NoiseParametersRef,
    shift: NoiseParametersRef,

    clamp: DensityClampData,
    mapped: DensityMappedData,
    mul_or_add: DensityMulOrAddData,
    two_argument: DensityTwoArgumentData,
    spline: DensitySplineData,
    constant: f64,
    y_clamped_gradient: DensityYClampedGradientData,
    find_top_surface: DensityFindTopSurfaceData,
};

pub const NoiseRouterData = struct {
    barrier_noise: *const DensityFunctionData,
    fluid_level_floodedness_noise: *const DensityFunctionData,
    fluid_level_spread_noise: *const DensityFunctionData,
    lava_noise: *const DensityFunctionData,
    temperature: *const DensityFunctionData,
    vegetation: *const DensityFunctionData,
    continents: *const DensityFunctionData,
    erosion: *const DensityFunctionData,
    depth: *const DensityFunctionData,
    ridges: *const DensityFunctionData,
    preliminary_surface_level: *const DensityFunctionData,
    final_density: *const DensityFunctionData,
    vein_toggle: *const DensityFunctionData,
    vein_ridged: *const DensityFunctionData,
    vein_gap: *const DensityFunctionData,
};

pub const SurfaceStoneDepthData = struct {
    offset: i32,
    add_surface_depth: bool,
    secondary_depth_range: i32,
    surface_type: CaveSurface,
};

pub const SurfaceYConditionData = struct {
    anchor: VerticalAnchor,
    surface_depth_multiplier: i32,
    add_stone_depth: bool,
};

pub const SurfaceWaterConditionData = struct {
    offset: i32,
    surface_depth_multiplier: i32,
    add_stone_depth: bool,
};

pub const SurfaceNoiseThresholdData = struct {
    noise: ResourceKey,
    min_threshold: f64,
    max_threshold: f64,
    is_3d: bool,
};

pub const SurfaceVerticalGradientData = struct {
    random_name: Identifier,
    true_at_and_below: VerticalAnchor,
    false_at_and_above: VerticalAnchor,
};

pub const SurfaceConditionSourceData = union(enum) {
    not: *const SurfaceConditionSourceData,
    stone_depth: SurfaceStoneDepthData,
    above_preliminary_surface,
    hole,
    y_above: SurfaceYConditionData,
    water: SurfaceWaterConditionData,
    biome: RegistryHolderSet,
    noise_threshold: SurfaceNoiseThresholdData,
    vertical_gradient: SurfaceVerticalGradientData,
    temperature,
    steep,
};

pub const SurfaceConditionRuleData = struct {
    condition: *const SurfaceConditionSourceData,
    then_run: *const SurfaceRuleSourceData,
};

pub const SurfaceRuleSourceData = union(enum) {
    bandlands,
    block: BlockStateSpec,
    sequence: []const *const SurfaceRuleSourceData,
    condition: SurfaceConditionRuleData,
};

pub const NoiseGeneratorSettingsData = struct {
    noise_settings: NoiseSettings,
    default_block: BlockStateSpec,
    default_fluid: BlockStateSpec,
    noise_router: *const NoiseRouterData,
    surface_rule: *const SurfaceRuleSourceData,
    spawn_target: []const ClimateParameterPoint,
    sea_level: i32,
    disable_mob_generation: bool,
    aquifers_enabled: bool,
    ore_veins_enabled: bool,
    use_legacy_random_source: bool,
};

// =============================================================================
// Density and surface constant data
// =============================================================================

pub const surface_on_floor: SurfaceConditionSourceData = .{ .stone_depth = .{
    .offset = 0,
    .add_surface_depth = false,
    .secondary_depth_range = 0,
    .surface_type = .floor,
} };

pub const surface_under_floor: SurfaceConditionSourceData = .{ .stone_depth = .{
    .offset = 0,
    .add_surface_depth = true,
    .secondary_depth_range = 0,
    .surface_type = .floor,
} };

pub const surface_deep_under_floor: SurfaceConditionSourceData = .{ .stone_depth = .{
    .offset = 0,
    .add_surface_depth = true,
    .secondary_depth_range = 6,
    .surface_type = .floor,
} };

pub const surface_very_deep_under_floor: SurfaceConditionSourceData = .{ .stone_depth = .{
    .offset = 0,
    .add_surface_depth = true,
    .secondary_depth_range = 30,
    .surface_type = .floor,
} };

pub const surface_on_ceiling: SurfaceConditionSourceData = .{ .stone_depth = .{
    .offset = 0,
    .add_surface_depth = false,
    .secondary_depth_range = 0,
    .surface_type = .ceiling,
} };

pub const surface_under_ceiling: SurfaceConditionSourceData = .{ .stone_depth = .{
    .offset = 0,
    .add_surface_depth = true,
    .secondary_depth_range = 0,
    .surface_type = .ceiling,
} };

// DensityFunctions.Constant.ZERO.

pub const density_constant_zero: DensityFunctionData = .{ .constant = 0.0 };

// SurfaceRuleData's simple block rules.

pub const surface_rule_air: SurfaceRuleSourceData = .{ .block = .{ .block = .air } };

pub const surface_rule_bedrock: SurfaceRuleSourceData = .{ .block = .{ .block = .bedrock } };

pub const surface_rule_white_terracotta: SurfaceRuleSourceData = .{ .block = .{ .block = .white_terracotta } };

pub const surface_rule_orange_terracotta: SurfaceRuleSourceData = .{ .block = .{ .block = .orange_terracotta } };

pub const surface_rule_terracotta: SurfaceRuleSourceData = .{ .block = .{ .block = .terracotta } };

pub const surface_rule_red_sand: SurfaceRuleSourceData = .{ .block = .{ .block = .red_sand } };

pub const surface_rule_red_sandstone: SurfaceRuleSourceData = .{ .block = .{ .block = .red_sandstone } };

pub const surface_rule_stone: SurfaceRuleSourceData = .{ .block = .{ .block = .stone } };

pub const surface_rule_deepslate: SurfaceRuleSourceData = .{ .block = .{ .block = .deepslate } };

pub const surface_rule_dirt: SurfaceRuleSourceData = .{ .block = .{ .block = .dirt } };

pub const surface_rule_podzol: SurfaceRuleSourceData = .{ .block = .{ .block = .podzol } };

pub const surface_rule_coarse_dirt: SurfaceRuleSourceData = .{ .block = .{ .block = .coarse_dirt } };

pub const surface_rule_mycelium: SurfaceRuleSourceData = .{ .block = .{ .block = .mycelium } };

pub const surface_rule_grass_block: SurfaceRuleSourceData = .{ .block = .{ .block = .grass_block } };

pub const surface_rule_calcite: SurfaceRuleSourceData = .{ .block = .{ .block = .calcite } };

pub const surface_rule_gravel: SurfaceRuleSourceData = .{ .block = .{ .block = .gravel } };

pub const surface_rule_sand: SurfaceRuleSourceData = .{ .block = .{ .block = .sand } };

pub const surface_rule_sandstone: SurfaceRuleSourceData = .{ .block = .{ .block = .sandstone } };

pub const surface_rule_packed_ice: SurfaceRuleSourceData = .{ .block = .{ .block = .packed_ice } };

pub const surface_rule_snow_block: SurfaceRuleSourceData = .{ .block = .{ .block = .snow_block } };

pub const surface_rule_mud: SurfaceRuleSourceData = .{ .block = .{ .block = .mud } };

pub const surface_rule_powder_snow: SurfaceRuleSourceData = .{ .block = .{ .block = .powder_snow } };

pub const surface_rule_ice: SurfaceRuleSourceData = .{ .block = .{ .block = .ice } };

pub const surface_rule_water: SurfaceRuleSourceData = .{ .block = .{ .block = .water } };

pub const surface_rule_lava: SurfaceRuleSourceData = .{ .block = .{ .block = .lava } };

pub const surface_rule_netherrack: SurfaceRuleSourceData = .{ .block = .{ .block = .netherrack } };

pub const surface_rule_soul_sand: SurfaceRuleSourceData = .{ .block = .{ .block = .soul_sand } };

pub const surface_rule_soul_soil: SurfaceRuleSourceData = .{ .block = .{ .block = .soul_soil } };

pub const surface_rule_basalt: SurfaceRuleSourceData = .{ .block = .{ .block = .basalt } };

pub const surface_rule_blackstone: SurfaceRuleSourceData = .{ .block = .{ .block = .blackstone } };

pub const surface_rule_warped_wart_block: SurfaceRuleSourceData = .{ .block = .{ .block = .warped_wart_block } };

pub const surface_rule_warped_nylium: SurfaceRuleSourceData = .{ .block = .{ .block = .warped_nylium } };

pub const surface_rule_nether_wart_block: SurfaceRuleSourceData = .{ .block = .{ .block = .nether_wart_block } };

pub const surface_rule_crimson_nylium: SurfaceRuleSourceData = .{ .block = .{ .block = .crimson_nylium } };

pub const surface_rule_end_stone: SurfaceRuleSourceData = .{ .block = .{ .block = .end_stone } };

pub const surface_rule_cinnabar: SurfaceRuleSourceData = .{ .block = .{ .block = .cinnabar } };

pub const surface_rule_sulfur: SurfaceRuleSourceData = .{ .block = .{ .block = .sulfur } };

pub const density_blend_alpha: DensityFunctionData = .blend_alpha;

pub const density_blend_offset: DensityFunctionData = .blend_offset;

pub const density_beardifier_marker: DensityFunctionData = .beardifier_marker;

pub const density_end_islands: DensityFunctionData = .end_islands;

pub const surface_above_preliminary_surface: SurfaceConditionSourceData = .above_preliminary_surface;

pub const surface_hole: SurfaceConditionSourceData = .hole;

pub const surface_temperature: SurfaceConditionSourceData = .temperature;

pub const surface_steep: SurfaceConditionSourceData = .steep;

pub const surface_bandlands: SurfaceRuleSourceData = .bandlands;
