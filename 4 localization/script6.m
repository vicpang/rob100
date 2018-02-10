clear all;
pg = PoseGraph('killian-small.toro');
pg.plot()
pg.optimize('animate')