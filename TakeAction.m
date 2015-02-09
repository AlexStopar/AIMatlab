function [ ChangedState ] = TakeAction( GoalState, action )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
blank = -1;
switched = -1;
for n = 1:9
   if GoalState(n) == 0
    blank = n;
   end
end

ChangedState = GoalState;
if(blank > 0)
switch action
    case Actions.LEFT
        if blank ~= 1 && blank ~= 4 && blank ~= 7
            switched = ChangedState(blank - 1);
            ChangedState(blank - 1) = ChangedState(blank);
            ChangedState(blank) = switched;
        end
    case Actions.RIGHT
        if blank ~= 3 && blank ~= 6 && blank ~= 9
            switched = ChangedState(blank + 1);
            ChangedState(blank + 1) = ChangedState(blank);
            ChangedState(blank) = switched;
        end
    case Actions.UP
         if blank ~= 1 && blank ~= 2 && blank ~= 3
            switched = ChangedState(blank - 3);
            ChangedState(blank - 3) = ChangedState(blank);
            ChangedState(blank) = switched;
         end
    case Actions.DOWN
        if blank ~= 7 && blank ~= 8 && blank ~= 9
            switched = ChangedState(blank + 3);
            ChangedState(blank + 3) = ChangedState(blank);
            ChangedState(blank) = switched;
         end
       
end
end

end

