data_act = csvread("InitialController.csv");
data_sim_3 = csvread("3rdOrder.csv");
data_sim_2 = csvread("2ndOrder.csv");

theta_act = data_act(:,2);
theta_sim_2 = data_sim_2(:,2);
theta_sim_3 = data_sim_3(:,2);

hold on;
plot(data_act(:,1), data_act(:,2));
plot(data_sim_2(:,1), data_sim_2(:,2));
plot(data_sim_3(:,1), data_sim_3(:,2));