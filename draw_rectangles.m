function[] = draw_rectangles(centre,patch_size,color)
x = centre(:,1);
y = centre(:,2);
h = size(x,1);
hold on;
top_x = x-(patch_size/2);
top_y = y-(patch_size/2);
rectangle('Position',[top_x(1,1) top_y(1,1) patch_size patch_size],'EdgeColor',color,'LineStyle','-');
%
for i=2:h
    rectangle('Position',[top_x(i,1) top_y(i,1) patch_size patch_size],'EdgeColor',color,'LineStyle','--');
    hold on;
end
end