%vid Prints frames according to event streams (i.e. vectors with elements in {0,1,2,3})

color_order = {'colorA','colorB','colorC','colorD'};
color_order2={'colorD','colorC','colorA','colorB'};

conditions = {'Cond1','Cond2','Cond3','Cond4'};
color_cond_names = {'Colors1','Colors2'};
args1={35000,133,2667,0.1};
args2={35000,133,2667,0.1,1067,0,1};
args3={35000,133,2667,0.1,533,0,1};
args4={35000,133,2667,0.1,533,0.5,1};
args_order = {args1,args2,args3,args4};

num_instances=4;

mkdir('../Generated_Frames');

for q=1:2
    for j=1:size(conditions,2)
        
        if q==1
            event_0=imread(strcat('../resources/', color_order{j},'/im0.png'));
            event_1=imread(strcat('../resources/', color_order{j},'/im1.png'));
            event_2=imread(strcat('../resources/', color_order{j},'/im2.png'));
            event_3=imread(strcat('../resources/', color_order{j},'/im3.png'));
        else
            event_0=imread(strcat('../resources/', color_order2{j},'/im0.png'));
            event_1=imread(strcat('../resources/', color_order2{j},'/im1.png'));
            event_2=imread(strcat('../resources/', color_order2{j},'/im2.png'));
            event_3=imread(strcat('../resources/', color_order2{j},'/im3.png'));
        end
        
        condition_folder_path=strcat('../Generated_Frames/', color_cond_names{q},'/', conditions{j});
        mkdir(condition_folder_path);

        %generate each instance of a condition
        for k=1:num_instances
            instance_folder_path = strcat(condition_folder_path,'/instance_',num2str(k) );
            mkdir(instance_folder_path);

            clear outcome;
            outcome = generate_Seq(args_order{j}{:});
            
            %print plot of each instance
            f = figure('visible','off'); 
            plot(outcome,'x');
            print(f, '-r80', '-dpng', strcat('../Generated_Frames/','condition',num2str(j),'_instance',num2str(k),'_colors',num2str(q),'.png'));
                
            
            %write frames for each instance
            for i=1:size(outcome,2)
                if outcome(i)==0
                    imwrite(event_0,strcat(instance_folder_path, '/frame_', num2str(i),'.png'),'png');
                end;
                if outcome(i)==1
                    imwrite(event_1,strcat(instance_folder_path, '/frame_', num2str(i),'.png'),'png');
                end;
                if outcome(i)==2
                    imwrite(event_2,strcat(instance_folder_path, '/frame_', num2str(i),'.png'),'png');
                end;
                if outcome(i)==3
                    imwrite(event_3,strcat(instance_folder_path, '/frame_', num2str(i),'.png'),'png');
                end;
            end;


        end
    end
end