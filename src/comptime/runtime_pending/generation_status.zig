//! Runtime/threading state preserved from the original archive.

pub const GenerationStatus = enum(u8) { empty, generating, primary_generating, writing, ready };
