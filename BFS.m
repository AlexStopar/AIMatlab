GoalState = [1, 2, 3, 4, 5, 6, 7, 8, 0];

IStates = cell(100, 1);
actionStepMax = 500;
for k = 1:100
    IStates{k} = GoalState;
    for n = 1:randi(actionStepMax)
        IStates{k} = TakeAction(IStates{k}, randi(Actions.DOWN));
    end
end
[IStates, idx, idx2] = uniquecell(IStates);
while length(IStates) < 100
   IStates{length(IStates) + 1} = [];
   IStates{length(IStates)} = GoalState;
   IStates{length(IStates)} = TakeAction(IStates{length(IStates)}, randi(Actions.DOWN));
   [IStates, idx, idx2] = uniquecell(IStates);
end


for j = 1:100
    node = struct('state', IStates{j}, 'pathcost', 0);
end
