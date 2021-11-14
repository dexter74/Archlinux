
**Vulkan**
```bash
pacman -S ----asexplicit vulkan-icd-loader lib32-vulkan-icd-loader ;
```


**Intel**
```bash
pacman -S ----asexplicit vulkan-intel ;
# OU
pacman -S ----asexplicit lib32-vulkan-intel ;
```

**NVIDIA**
```bash
pacman -S ----asexplicit nvidia-utils ; 
#OU
pacman -S ----asexplicit lib32-nvidia-utils ;
```

**AMD:**
```bash 
AMD: there are three implementations, which could be installed simultaneously:
 - vulkan-radeon (or lib32-vulkan-radeon) - RADV (part of Mesa project)
 - amdvlk (or lib32-amdvlk) - AMDVLK Open (maintained by AMD)
 - vulkan-amdgpu-proAUR (or lib32-vulkan-amdgpu-proAUR) - AMDVLK Closed (maintained by AMD)
```
