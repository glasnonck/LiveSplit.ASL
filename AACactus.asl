state("cactus"){
    bool on_score_screen : "gameoverlayrenderer.dll", 0x0EE876;
}

start {
    return old.on_score_screen != current.on_score_screen && !current.on_score_screen;
}

split {
    return old.on_score_screen != current.on_score_screen && current.on_score_screen;
}

isLoading {
    return current.on_score_screen;
}
