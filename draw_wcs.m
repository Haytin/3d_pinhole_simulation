function [] = draw_wcs(extension_factor, axis_length)
    hold on
        quiver3(0,0,0,axis_length*extension_factor,0,0,1.5,'r')
        quiver3(0,0,0,0,axis_length*extension_factor,0,1.5,'g')
        quiver3(0,0,0,0,0,axis_length*extension_factor,1.5,'b')
        text(0,0,0,'W')
    hold off
end

