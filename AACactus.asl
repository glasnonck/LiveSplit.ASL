state("cactus"){
    bool on_score_screen : "mono.dll", 0x1F7C2C, 0x78, 0x684, 0x100, 0x3CC, 0xD4;
}

split {
    return old.on_score_screen != current.on_score_screen && current.on_score_screen;
}

isLoading {
    return current.on_score_screen || old.on_score_screen;
}
