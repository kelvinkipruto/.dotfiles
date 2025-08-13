{ self, pkgs, ... }:
{
  # Font configurations are now handled by shared configuration
  # Darwin-specific font settings can be added here if needed
  fonts = {
    # Additional Darwin-specific font packages can be added here
    packages = with pkgs; [
      # Add any macOS-specific fonts here if needed
    ];
  };
}
