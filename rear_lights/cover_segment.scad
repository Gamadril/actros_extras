module segment(w,h,e) {
    a = 1.3;
    b = 1.8;
    linear_extrude(e)
        polygon([
            [0, 0],
            [w, 0],
            [w+a, b],
            [w+a, h-b],
            [w, h],
            [0, h],
            [a, h-b],
            [a, b],
        ]);
}

segment(4.0, 8.8-2*0.6, 0.8);